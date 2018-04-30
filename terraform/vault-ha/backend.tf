terraform {
  backend "s3" {
    bucket = "terraform-mw"
    key = "do/vault-ha"
    region = "us-east-1"
  }
}
