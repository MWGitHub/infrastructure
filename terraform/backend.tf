terraform {
  backend "gcs" {
    prefix = "terraform/state"
    credentials = "../gcs-backend.json"
  }
}
