output subnetwork {
  value = "${google_compute_subnetwork.subnetwork.self_link}"
}

output subnetwork_secondary_cluster {
  value = "${google_compute_subnetwork.subnetwork.secondary_ip_range[0]}"
}

output subnetwork_secondary_services {
  value = "${google_compute_subnetwork.subnetwork.secondary_ip_range[1]}"
}
