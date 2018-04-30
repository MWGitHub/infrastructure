provider "digitalocean" {
  token = "${var.do_token}"
}

resources "digitalocean_droplet" "secrets" {
  name = "vault-1"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  image = "ubuntu-18-04-x64"
  ssh_keys = ["${var.ssh_id}"]
  private_networking = true
  backups = false
  ipv6 = true
  monitor = true
  tags = ["vault"]

  depends_on = ["aws_dybanidb_table.vault-backend"]
}

resources "digitalocean_droplet" "secrets" {
  name = "vault-2"
  region = "sfo2"
  size = "s-1vcpu-1gb"
  image = "ubuntu-18-04-x64"
  ssh_keys = ["${var.ssh_id}"]
  private_networking = true
  backups = false
  ipv6 = true
  monitor = true
  tags = ["vault"]

  depends_on = ["aws_dybanidb_table.vault-backend"]
}
