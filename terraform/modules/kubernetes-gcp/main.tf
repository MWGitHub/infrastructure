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

module "cluster-us-east" {
  source = "./cluster"
  name = "cluster-us-east"
  region = "us-east1"
  master_cidr = "10.1.1.0/28"
  network_link = "${module.network.link}"
  subnetwork_link = "${module.subnetwork-us-east.link}"
  subnetwork_secondary_cluster = "${module.subnetwork-us-east.secondary_cluster}"
  subnetwork_secondary_services = "${module.subnetwork-us-east.secondary_services}"
}

module "cluster-us-west" {
  source = "./cluster"
  name = "cluster-us-west"
  region = "us-west1"
  master_cidr = "10.1.2.0/28"
  network_link = "${module.network.link}"
  subnetwork_link = "${module.subnetwork-us-west.link}"
  subnetwork_secondary_cluster = "${module.subnetwork-us-west.secondary_cluster}"
  subnetwork_secondary_services = "${module.subnetwork-us-west.secondary_services}"
}
