output "public" {
  value = "${digitalocean_tag.public.name}"
}


output "restricted" {
  value = "${digitalocean_tag.restricted.name}"
}

output "ssh" {
  value = "${digitalocean_tag.ssh.name}"
}
