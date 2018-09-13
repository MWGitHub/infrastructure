provider "google" {
  version = "~> 1.17"
  project = "${var.project_id}"
}

module "network" {
  source = "./network"
}

module "subnetwork-us-east" {
  source = "./subnetwork"
  name = "subnetwork-us-east"
  network_link = "${module.network.link}"
  cidr_range = "10.100.0.0/16"
  region = "us-east1"
  cluster_range = "10.101.0.0/16"
  cluster_name = "subnetwork-secondary-cluster-us-east"
  service_range = "10.102.0.0/16"
  service_name = "subnetwork-secondary-service-us-east"
}

module "subnetwork-us-west" {
  source = "./subnetwork"
  name = "subnetwork-us-west"
  network_link = "${module.network.link}"
  cidr_range = "10.105.0.0/16"
  region = "us-west1"
  cluster_range = "10.106.0.0/16"
  cluster_name = "subnetwork-secondary-cluster-us-west"
  service_range = "10.107.0.0/16"
  service_name = "subnetwork-secondary-service-us-west"
}
