# infrastructure

Setting up and managing infrastructure.

## Repositories  

The main repository now exists on GitLab (https://gitlab.com/mwguy/infrastructure), GitHub will be a mirror.

## Installation

Install terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) and put it into your path.

Install aws cli at [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/) and log in with it with aws configure.


## Usage

First create the backend resources
```bash
git clone git@github.com:MWGitHub/infrastructure.git
cd terraform/setup/backend
terraform init # initializes the providers needed on first run
terraform apply # creates the hardware
```

Create the rest of the resources
```bash
cd ../../network
terraform init
terraform apply
```

## Reasonings

* Before a backend is created, the infrastructure for it also must be made.
    * backend-provision has destroy turned off so state cannot be accidentally lost easily.
* The `backend.tf` file is copied and changed so state collision does not occur.
