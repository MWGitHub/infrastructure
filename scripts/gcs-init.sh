#!/usr/bin/env bash

# Log in to GCS before doing executing

project_id=$1
bucket=$2

case $1 in
    -h|--help|-\?)
    printf "%s\n%s\n" "Creates the required resources for the backend." "Usage: project_id bucket"
    exit;
esac

if [ "$#" -ne 2 ]; then
    echo "expected project_id as the first argument and bucket as the second"
    exit;
fi

# Create the bucket if needed
gsutil mb -p "$project_id" -c regional -l us-east1 gs://"$bucket"/

# Create a service account for terraform backend
gcloud iam service-accounts create tf-backend --display-name "tf-backend"

# Give permissions for the service account
gsutil iam ch serviceAccount:tf-backend@"$project_id".iam.gserviceaccount.com:objectAdmin gs://"$bucket"/

# Generate service account key
gcloud iam service-accounts keys create gcs-backend.json --iam-account tf-backend@"$project_id".iam.gserviceaccount.com
