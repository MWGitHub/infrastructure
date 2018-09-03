#!/usr/bin/env bash

script_name=$(basename $0)

# Log in to GCS before doing executing
if [ -z "$(which gcloud)" ]; then
    echo "gcloud is not installed, check the README on installation steps." >&2
    exit 1
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
    echo "Usage error (use -h for help)" >&2
    exit 2
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

# Create the project if needed otherwise assume a project already is created when given just the id.
if [ -n "$project_name" ]; then
    organization_flag=
    if [ -n "$organization_flag" ]; then
        organization_flag=" --organization=$organization_id"
    fi
    gcloud projects create "$project_id" --name="$project_name" "$organization_flag"
fi

# Create the bucket if needed
gsutil mb -p "$project_id" -c regional -l "$region" gs://"$bucket"/

# Create a service account for terraform backend
gcloud iam service-accounts create terraform-backend --display-name "terraform-backend"

# Give permissions for the service account
gsutil iam ch serviceAccount:terraform-backend@"$project_id".iam.gserviceaccount.com:objectAdmin gs://"$bucket"/

# Generate service account key
gcloud iam service-accounts keys create terraform-backend.json --iam-account terraform-backend@"$project_id".iam.gserviceaccount.com
