output "firewall_public" {
  value = "${digitalocean_firewall.public.id}"
}

output "firewall_restricted" {
  value = "${digitalocean_firewall.restricted.id}"
}

output "firewall_whitelist" {
  value = "${digitalocean_firewall.whitelist.id}"
}
