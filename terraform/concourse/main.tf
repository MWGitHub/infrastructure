provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "web" {
  name               = "concourse-db-1"
  region             = "nyc3"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-16-04-x64"
//  ssh_keys           = ["${var.ssh_id}"]
  private_networking = true
  backups            = true
  ipv6               = true
  monitoring         = true
  tags               = ["concourse"]
}
