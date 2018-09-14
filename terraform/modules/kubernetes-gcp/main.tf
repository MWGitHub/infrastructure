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
  cidr_range = "10.110.0.0/16"
  region = "us-east1"
  cluster_range = "10.111.0.0/16"
  cluster_name = "subnetwork-secondary-cluster-us-east"
  service_range = "10.112.0.0/16"
  service_name = "subnetwork-secondary-service-us-east"
}

module "subnetwork-us-west" {
  source = "./subnetwork"
  name = "subnetwork-us-west"
  network_link = "${module.network.link}"
  cidr_range = "10.120.0.0/16"
  region = "us-west1"
  cluster_range = "10.121.0.0/16"
  cluster_name = "subnetwork-secondary-cluster-us-west"
  service_range = "10.122.0.0/16"
  service_name = "subnetwork-secondary-service-us-west"
}
