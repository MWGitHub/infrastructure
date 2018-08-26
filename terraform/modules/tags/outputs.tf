output "external" {
  value = "${digitalocean_tag.external.name}"
}


output "internal" {
  value = "${digitalocean_tag.internal.name}"
}

output "ssh" {
  value = "${digitalocean_tag.ssh.name}"
}

output "whitelist" {
  value = "${digitalocean_tag.whitelist.name}"
}
