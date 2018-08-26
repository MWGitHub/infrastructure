provider "digitalocean" {
  token = "${var.do_token}"
}

module "tags" {
  source = "./modules/tags"
}

module "firewall" {
  source = "./modules/firewall"

  public = "${module.tags.public}"
  restricted = "${module.tags.restricted}"
  ssh = "${module.tags.ssh}"
  ssh_ips = "${var.ssh_ips}"
  restricted_ips = "${var.restricted_ips}"
}
