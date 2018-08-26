provider "digitalocean" {
  token = "${var.do_token}"
}

module "do-tags" {
  source = "./modules/do-tags"
}
