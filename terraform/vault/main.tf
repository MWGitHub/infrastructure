variable do_token {}
variable ssh_id {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "secrets" {
  name = "vault-1"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-18-04-x64"
  ssh_keys = ["${var.ssh_id}"]
  private_networking = true
  backups = false
  ipv6 = true
  monitor = true
  tags = ["vault"]

  depends_on = ["aws_dynamodb_table.vault_backend"]
}
