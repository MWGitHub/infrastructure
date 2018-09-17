resource "google_container_cluster" "cluster" {
  name = "${var.name}"
  region = "${var.region}"

  # Networking
  master_ipv4_cidr_block = "${var.master_cidr}"
  network = "${var.network_link}"
  subnetwork = "${var.subnetwork_link}"
  ip_allocation_policy {
    cluster_secondary_range_name = "${var.subnetwork_secondary_cluster}"
    services_secondary_range_name = "${var.subnetwork_secondary_services}"
  }
  network_policy {
    provider = "CALICO"
    enabled = true
  }
  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  # Security
  master_auth {
    password = ""
    username = ""
    client_certificate_config {
      issue_client_certificate = true
    }
  }
  pod_security_policy_config {
    enabled = false
  }
  maintenance_policy {
    "daily_maintenance_window" {
      start_time = "09:00"
    }
  }

  # Nodes
  initial_node_count = 1
  remove_default_node_pool = true
}

locals {
  standard_node_name = "standard"
}

resource "google_container_node_pool" "standard" {
  name = "${local.standard_node_name}"
  cluster = "${google_container_cluster.cluster.name}"
  region = "${var.region}"
  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
  management {
    auto_repair = true
    auto_upgrade = true
  }
  node_config {
    image_type = "COS"
    machine_type = "n1-standard-1"
    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring"
    ]
    preemptible = true
    tags = [
      "node",
      "${local.standard_node_name}",
      "${var.name}",
      "${var.region}"
    ]
    labels {
      "type" = "pool"
      "name" = "${var.name}"
      "region" = "${var.region}"
    }
  }
}
