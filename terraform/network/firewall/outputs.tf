output "firewall_id" {
  value = "${digitalocean_firewall.restricted.id}"
}

output "firewall_tag" {
  value = "restricted"
}
