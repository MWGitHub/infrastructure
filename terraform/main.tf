terraform {
  required_version = "~> 0.11.8"

  backend "gcs" {}
}

module "kubernetes-gcp" {
  source = "./modules/kubernetes-gcp"
  project_id = "${var.project_id}"
}
