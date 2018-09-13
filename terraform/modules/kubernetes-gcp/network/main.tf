resource "google_compute_network" "network" {
  name = "${var.name}"
  description = "Main network for the services."
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
}
