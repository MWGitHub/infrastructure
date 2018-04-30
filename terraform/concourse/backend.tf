# Use the credentials in the default path for now
# Use -lock=false for now
terraform {
  backend "gcs" {
    bucket      = "build-tf"
    prefix      = "terraform/state"
    credentials = "local/key.json"
  }
  required_version = "~> 0.11.0"
}
