# infrastructure

Setting up and managing infrastructure.

## Installation

Install terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) and put it into your path.

Install aws cli at [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/) and log in with it with aws configure.


## Usage

First create the backend resources
```bash
git clone git@github.com:MWGitHub/infrastructure.git
cd terraform/backend-provision
terraform init # initializes the providers needed on first run
terraform apply # creates the hardware
```

## Reasonings

* Before a backend is created, the infrastructure for it also must be made.
    * backend-provision has destroy turned off in so state cannot be accidentally lost as easily.
* The `backend.tf` file is copied and changed so that state collision does not occur.
