output "firewall_external" {
  value = "${digitalocean_firewall.external.id}"
}

output "firewall_internal" {
  value = "${digitalocean_firewall.internal.id}"
}

output "firewall_whitelist" {
  value = "${digitalocean_firewall.whitelist.id}"
}
