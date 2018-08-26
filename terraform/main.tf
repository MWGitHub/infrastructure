provider "digitalocean" {
  token = "${var.do_token}"
}

module "do-tags" {
  source = "./modules/do-tags"
}

module "do-firewall" {
  source = "./modules/do-firewall"

  public = "${module.do-tags.public}"
  restricted = "${module.do-tags.restricted}"
  ssh = "${module.do-tags.ssh}"
  ssh_ips = "${var.ssh_ips}"
  restricted_ips = "${var.restricted_ips}"
}
