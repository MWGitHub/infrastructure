terraform {
  required_version = "~> 0.11.8"

  backend "gcs" {
    prefix = "terraform/state"
    credentials = "../terraform-backend.json"
  }
}

module "kubernetes-gcp" {
  source = "./modules/kubernetes-gcp"
  project_id = "${var.project_id}"
}
