output link {
  value = "${google_compute_subnetwork.subnetwork.self_link}"
}

output secondary_cluster {
  value = "${google_compute_subnetwork.subnetwork.secondary_ip_range.0.range_name}"
}

output secondary_services {
  value = "${google_compute_subnetwork.subnetwork.secondary_ip_range.1.range_name}"
}
