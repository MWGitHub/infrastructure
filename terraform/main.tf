terraform {
  required_version = "~> 0.11.8"

  backend "gcs" {
    prefix = "terraform/state"
    credentials = "../gcs-backend.json"
  }
}
