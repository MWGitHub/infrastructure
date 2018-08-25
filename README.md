# infrastructure

Setting up and managing infrastructure.

## Repositories  

The main repository now exists on GitLab (https://gitlab.com/mwguy/infrastructure), GitHub will be a mirror.

## Installation

Install terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) and put it into your path.

Install the google cloud sdk at [https://cloud.google.com/sdk/](https://cloud.google.com/sdk/).

`git clone git@gitlab.com:mwguy/infrastructure.git`

`cd infrastructure`

## Usage

### Backend Creation

1. Log into google cloud by executing  
   `gcloud init`
1. Execute the following shell command to set up the storage (this only needs to be run once)   
   `./scripts/gcs-init.sh [PROJECT_ID] [UNIQUE_BUCKET_NAME]`  
   This will also output your service account credentials
1. Create or use an existing DigitalOcean token
1. `cd terraform`
1. Initialize the backend with the bucket name  
   `terraform init -input=true`  
   1. input the `[UNIQUE_BUCKET_NAME]`

## Reasoning

* The storage and permissions for the backend are provisioned in a separate script so the backend can access it.
* Permissions on the backend service account is limited to operations within the terraform bucket for security purposes.
