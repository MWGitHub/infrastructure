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
  whitelist = "${module.tags.whitelist}"

  whitelist_ips = "${var.whitelist_ips}"
}
