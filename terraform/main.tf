provider "digitalocean" {
  token = "${var.do_token}"
}

module "tags" {
  source = "./modules/tags"
}

module "firewall" {
  source = "./modules/firewall"

  external = "${module.tags.external}"
  internal = "${module.tags.internal}"
  ssh = "${module.tags.ssh}"
  whitelist = "${module.tags.whitelist}"

  whitelist_ips = "${var.whitelist_ips}"
}
