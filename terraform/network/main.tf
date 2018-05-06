variable do_token {}
variable vault_ssh_id {}
variable vault_private_key_path {}


provider "aws" {
  region = "us-east-1"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

module "tags" {
  source = "./tags"
}

module "firewall" {
  source = "./firewall"

  restricted_tag = "${module.tags.restricted}"
}

module "vault" {
  source = "./vault"

  vault_ssh_id = "${var.vault_ssh_id}"
  firewall_restricted_tag = "${module.tags.restricted}"
  vault_private_key_path = "${var.vault_private_key_path}"
}
