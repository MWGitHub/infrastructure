# Example of using terraform state

terraform {
  backend "s3" {
    bucket = "mw-terraform-states"
    key = "vault" # Switch this to the application name
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
