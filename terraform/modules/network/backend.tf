# Example of using terraform state

terraform {
  backend "s3" {
    bucket = "mw-terraform-states"
    key = "root"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
