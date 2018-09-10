output network_main_link {
  value = "${google_compute_network.main.self_link}"
}

output subnetwork_east {
  value = "${google_compute_subnetwork.east.self_link}"
}

output subnetwork_secondary_cluster_east {
  value = "${google_compute_subnetwork.east.secondary_ip_range[0].range_name}"
}

output subnetwork_secondary_services_east {
  value = "${google_compute_subnetwork.east.secondary_ip_range[1].range_name}"
}
