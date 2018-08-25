# infrastructure

Setting up and managing infrastructure.

## Repositories  

The main repository now exists on GitLab (https://gitlab.com/mwguy/infrastructure), GitHub will be a mirror.

## Installation

Install terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) and put it into your path.

Install the google cloud sdk at [https://cloud.google.com/sdk/](https://cloud.google.com/sdk/).

## Usage

1. Log into google cloud by executing  
   `gcloud init`
1. Execute the following shell command to set up the storage (this only needs to be run once)   
   `./scripts/gcs-init.sh [PROJECT_ID] [UNIQUE_BUCKET_NAME]`
1. Create or use an existing DigitalOcean token 

Create all the terraform resources.
```bash
git clone git@gitlab.com:mwguy/infrastructure.git
cd terraform
terraform init
terraform apply
```

## Reasonings

* Terraform's initial state to create the backend is stored locally
    * To limit the danger of destroying an existing backend, destroy is turned off on the backend configuration
