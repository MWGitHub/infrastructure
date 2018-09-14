resource "google_compute_subnetwork" "subnetwork" {
  name = "${var.name}"
  network = "${var.network_link}"
  ip_cidr_range = "${var.cidr_range}"
  enable_flow_logs = true
  private_ip_google_access = true
  region = "${var.region}"
  secondary_ip_range {
    ip_cidr_range = ""
    range_name = ""
  }
  secondary_ip_range {
    ip_cidr_range = "${var.cluster_range}"
    range_name = "${var.cluster_name}"
  }
  secondary_ip_range {
    ip_cidr_range = "${var.service_range}"
    range_name = "${var.service_name}"
  }
}
