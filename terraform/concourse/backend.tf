# Example of using terraform state

terraform {
  backend "s3" {
    bucket = "mw-terraform-states"
    key = "concourse-state"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
