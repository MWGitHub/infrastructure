# infrastructure

Setting up and managing infrastructure.

## Repositories  

The main repository now exists on GitLab (https://gitlab.com/mwguy/infrastructure), GitHub will be a mirror.

## Installation

Install terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) and put it into your path.

Install the google cloud sdk at [https://cloud.google.com/sdk/](https://cloud.google.com/sdk/).

`git clone git@gitlab.com:mwguy/infrastructure.git`

`cd infrastructure`

### Environment Credentials (optional)

Environment credentials will allow some steps to be skipped such as creating a service account though it is still advisable.

These are the credentials that can be used for ease of use:
* `export GOOGLE_APPLICATION_CREDENTIALS="[PATH]"` for gcs credentials
* `export INFRA_PROJECT="[PROJECT_ID]` the project ID to use
* `export INFRA_BUCKET=[BUCKET]` the name of the bucket
* `export TF_VAR_do_token=[DO_TOKEN]` the Digital Ocean token

## Usage

### Backend Creation

The backend is used not the same as a website backend. This is used to store terraform state data.

1. Log into google cloud by executing  
   `gcloud init`
1. Execute the following shell command to set up the storage (this only needs to be run once)   
   `./scripts/backend-init.sh [PROJECT_ID] [UNIQUE_BUCKET_NAME]`  
   This will also output your service account credentials
1. Create or use an existing DigitalOcean token
1. `cd terraform`
1. Initialize the backend with the bucket name  
   `terraform init -input=true`  
   1. input the `[UNIQUE_BUCKET_NAME]`
   
### Network Creation



## Reasoning

* The storage and permissions for the backend are provisioned in a separate script so the backend can access it.
* Permissions on the backend service account is limited to operations within the terraform bucket for security purposes.
