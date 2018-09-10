locals {
  name = "east-cluster"
}

resource "google_container_cluster" "east" {
  name = "${local.name}"
  description = "Cluster covering the east coast and western europe."
  region = "${var.region}"

  # Networking
  master_ipv4_cidr_block = "10.1.0.0/28"
  cluster_ipv4_cidr = "10.2.0.0/16"
  network = "${var.network_main_link}"
  subnetwork = "${var.subnetwork_east}"
  master_authorized_networks_config {
    cidr_blocks = {
      cidr_block = "${var.master_authorized_networks}"
      display_name = "Single Addresses"
    }
  }
  ip_allocation_policy {
    cluster_secondary_range_name = "${var.subnetwork_secondary_cluster_east}"
    services_secondary_range_name = "${var.subnetwork_secondary_services_east}"
  }
  network_policy {

  }

  # Nodes
  initial_node_count = 0

  node_config {

  }
  private_cluster = true
  remove_default_node_pool = true
  resource_labels = {
    "type" = "cluster",
    "name" = "${local.name}"
    "region" = "${var.region}"
  }
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    },
    http_load_balancing {
      disabled = true
    }
    network_policy_config {
      disabled = false
    }
  }
}
