#!/usr/bin/env bash

script_name=$(basename $0)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

error () {
    local status="${2:-1}"

    printf "ERROR: %s\n" "$1" >&2
    exit "$status"
}

# Log in to GCS before executing
if [ -z "$(which gcloud)" ]; then
     error "gcloud is not installed, check the README on installation steps."
fi

function print_help () {
    echo "Usage [OPTION]... [project-id] [bucket-name]"
    echo "Creates a project and a bucket if needed."
    echo "Options:"
    printf '\t%s\n\t\t%s\n' "-h, --help" "prints help"
    printf '\t%s\n\t\t%s\n' "-o, --organization-id" "organization id to attach the bucket to"
    printf '\t%s\n\t\t%s\n' "-p, --project-name" "name of the project to create"
    printf '\t%s\n\t\t%s\n' "-r, --region" "region to create the bucket"
}

# Get arguments
getopt -T > /dev/null
if [ $? -eq 4 ]; then
    args=$(getopt -n "$script_name" -o ho:p:r: --long help,organization-id:,project-name:,region: -- "$@")
else
    args=$(getopt ho:p:r: "$@")
fi
if [ $? -ne 0 ]; then
    error "Usage error (use -h for help)" 2
fi
eval set -- "${args}"

organization_id=
project_name=
project_id=
region="us-central1"
bucket=

while true; do
    case "$1" in
        -h|--help)
            print_help
            exit 0
            ;;
        -o|--organization-id)
            organization_id="$2"
            shift;shift
            ;;
        -p|--project-name)
            project_name="$2"
            shift;shift
            ;;
        -r|--region)
            region="$2"
            shift;shift
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

project_id=$1
bucket=$2

if [ -z "$project_id" ] || [ -z "$bucket" ]; then
    error "[project-id] and [bucket-name] are required"
fi

# Create the project if needed
function create_project () {
    local project_exists
    project_exists=$(gcloud projects describe "$project_id" | grep name)

    if [ -n "$project_exists" ]; then
        return 0
    fi

    local organization_flag=
    if [ -n "$organization_flag" ]; then
        organization_flag=" --organization=$organization_id"
    fi
    local name_flag=
    if [ -n "$project_name" ]; then
        name_flag=" --name=$project_name"
    fi

    gcloud projects create "$project_id" "$name_flag" "$organization_flag"
}

# Create the bucket if needed
function create_bucket () {
    local bucket_exists=
    bucket_exists=$(gsutil ls -b gs://"$bucket" 2>&1 | grep 404)
    if [ -z "$bucket_exists" ]; then
        return 0
    fi
    gsutil mb -p "$project_id" -c regional -l "$region" gs://"$bucket"/
}

# Create the service account for just backend access
function create_backend_service () {
    local service_exists=
    service_exists=$(gcloud iam service-accounts describe terraform-backend@infrastructure-mw.iam.gserviceaccount.com | grep name)
    if [ -z "$service_exists" ]; then
        gcloud iam service-accounts create terraform-backend --display-name "terraform-backend"
    fi

    local service_account=terraform-backend@"$project_id".iam.gserviceaccount.com

    # Give permissions
    gsutil iam ch serviceAccount:"$service_account":objectAdmin gs://"$bucket"/

    # Generate account key
    if [ ! -e "$script_dir/../terraform-backend.json" ]; then
        local existing_key=
        existing_key=$(gcloud iam service-accounts keys list --iam-account="$service_account" \
         | awk 'NR==2 && $1 !~ /KEY_ID/ { print $1 }')
         if [ -n "$existing_key" ]; then
            gcloud iam service-accounts keys delete "$existing_key" --iam-account="$service_account" -q
         fi
        gcloud iam service-accounts keys create "$script_dir/../terraform-backend.json" --iam-account "$service_account"
    fi
}

function init_backend () {
    cd "$script_dir/../terraform" || error "No terraform directory found"
    terraform init \
        -backend-config="project=$project_id" \
        -backend-config="bucket=$bucket"
}

create_project
create_bucket
create_backend_service
init_backend

echo "Backend is initialized"
