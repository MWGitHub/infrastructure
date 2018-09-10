provider "google" {
  version = "~> 1.17"
  project = "${var.project_id}"
}

module "network" {
  source = "./network"
}

module "cluster" {
  source = "./cluster"
  master_authorized_networks = "${var.master_authorized_networks}"
  network_main_link = "${module.network.network_main_link}"
  subnetwork_east = "${module.network.subnetwork_east}"
  subnetwork_secondary_cluster_east = "${module.network.subnetwork_secondary_cluster_east}"
  subnetwork_secondary_services_east = "${module.network.subnetwork_secondary_services_east}"
}
