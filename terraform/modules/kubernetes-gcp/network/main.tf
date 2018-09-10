resource "google_compute_network" "main" {
  name = "network-main"
  description = "Main network for the services."
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
}

resource "google_compute_subnetwork" "east" {
  name = "subnetwork-east"
  network = "${google_compute_network.main.self_link}"
  ip_cidr_range = "10.100.0.0/16"
  enable_flow_logs = false
  private_ip_google_access = true
  region = "us-east1"

  secondary_ip_range = [
    {
      ip_cidr_range = "10.101.0.0/16"
      range_name = "subnetwork-secondary-cluster-east"
    },
    {
      ip_cidr_range = "10.102.0.0/16"
      range_name = "subnetwork-secondary-services-east"
    }
  ]
}
