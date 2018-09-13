#!/usr/bin/env bash
#
# Initialize the backend accounts and services if needed.
# This script can be run multiple times without issue as long as
# the identifiers do not change.

SCRIPT_NAME=$(basename $0)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"
BACKEND_KEY_FILE=".terraform-backend.json"

error() {
  local string="${1:-'invalid operation'}"
  local status="${2:-1}"

  printf "ERROR: %s\n" "${string}" >&2
  exit "$status"
}

# Check if gcloud is installed.
if [ -z "$(which gcloud)" ]; then
  error "gcloud is not installed, check the README on installation steps."
fi

print_help () {
  local env_format='\t%s\n\t\t%s\n\t\t%s\n'

  echo "Usage [OPTION]... [project-id] [bucket-name]"
  echo "Creates a project and a bucket if needed."
  echo "Options:"
  printf '\t%s\n\t\t%s\n' "-h, --help" "prints help"
  printf '\t%s\n\t\t%s\n' "-m, --make" "remakes the backend file"
  printf "${env_format}" "-o, --organization-id" \
    "organization id to attach the bucket to" \
    "env default: TF_BACKEND_INFRASTRUCTURE_ORGANIZATION_ID"
  printf "${env_format}" "-p, --project-name" \
    "name of the project to create" \
    "env default: TF_BACKEND_INFRASTRUCTURE_PROJECT_NAME"
  printf "${env_format}" "-r, --region" \
    "region to create the bucket" \
    "env default: TF_BACKEND_INFRASTRUCTURE_REGION"
  printf "${env_format}\t\t%s\n" "-P, --prefix" \
    "path to store terraform state within the bucket" \
    "env default: TF_BACKEND_INFRASTRUCTURE_PREFIX" \
    "default: terraform/state"
  printf '\n%s\n\t%s\n\t%s\n' "Environment variables for default paramters:" \
    "project id: TF_BACKEND_INFRASTRUCTURE_PROJECT_ID" \
    "bucket: TF_BACKEND_INFRASTRUCTURE_BUCKET"
}

# Get arguments keeping in mind the getopt version.
getopt -T > /dev/null
if [ $? -eq 4 ]; then
  args=$(getopt -n "${SCRIPT_NAME}" -o hmo:p:r:P: --long help,make,organization-id:,project-name,region:,prefix: -- "$@")
else
  args=$(getopt ho:p:r:P: "$@")
fi
eval set -- "${args}"

make=
organization_id=
project_name=
region=
prefix=
project_id=
bucket=

while true; do
  case "$1" in
    -h|--help)
      print_help
      exit 0
      ;;
    -m|--make)
      make=true
      shift;
      ;;
    -o|--organization-id)
      organization_id=${2:-$TF_BACKEND_INFRASTRUCTURE_ORGANIZATION_ID}
      shift;shift
      ;;
    -n|--project-name)
      project_name=${2:-$TF_BACKEND_INFRASTRUCTURE_PROJECT_NAME}
      shift;shift
      ;;
    -r|--region)
      region=${2:-$TF_BACKEND_INFRASTRUCTURE_REGION}
      shift;shift
      ;;
    -P|--prefix)
      prefix=${2:-$TF_BACKEND_INFRASTRUCTURE_PREFIX}
      shift;shift;
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac
done

# Set defaults on parameters that are optional
prefix=${prefix:-'terraform/state'}

# Set defaults on required parameters
project_id=${1:-$TF_BACKEND_INFRASTRUCTURE_PROJECT_ID}
bucket=${2:-$TF_BACKEND_INFRASTRUCTURE_BUCKET}

if [ -z "${project_id}" ] || [ -z "${bucket}" ]; then
  error "[project-id] and [bucket-name] are required"
fi

# Create the project if needed
create_project() {
  local project_exists
  project_exists=$(gcloud projects describe "${project_id}" | grep name)

  if [ -n "${project_exists}" ]; then
    return 0
  fi

  local organization_flag=
  if [ -n "${organization_flag}" ]; then
    organization_flag=" --organization=${organization_id}"
  fi
  local name_flag=
  if [ -n "${project_name}" ]; then
    name_flag=" --name=${project_name}"
  fi

  gcloud projects create \
    "${project_id}" \
    "${name_flag}" \
    "${organization_flag}"
}

# Create the bucket if needed
create_bucket() {
  local bucket_exists=
  bucket_exists=$(gsutil ls -b gs://"${bucket}" 2>&1 | grep 404)
  if [ -z "${bucket_exists}" ]; then
    return 0
  fi
  gsutil mb -p "${project_id}" -c regional -l "${region}" gs://"${bucket}"/
}

# Create the service account for just backend access
create_backend_service() {
  local service_account=terraform-backend@"${project_id}".iam.gserviceaccount.com
  local service_exists=
  service_exists=$(gcloud iam service-accounts describe "${service_account}" | grep name)
  if [ -z "${service_exists}" ]; then
    gcloud iam service-accounts create terraform-backend --display-name "terraform-backend"
  fi

  # Give permissions
  gsutil iam ch serviceAccount:"${service_account}":objectAdmin gs://"${bucket}"/

  # Generate account key
  local backend_key_path="${SCRIPT_DIR}/../.terraform-backend.json"
  if [ ! -e "${backend_key_path}" ]; then
    local existing_key=
    existing_key=$(gcloud iam service-accounts keys list --iam-account="$service_account" \
     | awk 'NR==2 && $1 !~ /KEY_ID/ { print $1 }')
     if [ -n "${existing_key}" ]; then
       gcloud iam service-accounts keys delete "${existing_key}" --iam-account="${service_account}" -q
     fi
    gcloud iam service-accounts keys create "${backend_key_path}" --iam-account "${service_account}"
  fi
}

init_backend() {
  local backend_file_name="backend.tfvars"
  local backend_file="${SCRIPT_DIR}/../${backend_file_name}"

  append_var() {
      local key=$1
      local value=$2
      if [ -n "${value}" ]; then
          printf '%s\n' "${key} = \"${value}\"" >> "${backend_file}"
      fi
  }

  if [ ! -e "${backend_file}" ] || [ -n "${make}" ]; then
    if [ -e "${backend_file}" ]; then
      rm "${backend_file}"
    fi
    touch "${backend_file}"
    append_var "bucket" "${bucket}"
    append_var "prefix" "${prefix}"
    append_var "credentials" "${BACKEND_KEY_FILE}"
  fi

  (
    cd "${SCRIPT_DIR}/../" || error
    terraform init \
      -backend-config="${backend_file_name}" \
      -lock=true \
      -input=false
  )
}

create_project
create_bucket
create_backend_service
init_backend

echo "Backend is initialized"
