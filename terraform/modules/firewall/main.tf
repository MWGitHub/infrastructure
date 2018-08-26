locals {
  outbound_rule = [
    {
      protocol = "tcp"
      port_range = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "udp"
      port_range = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "icmp"
      port_range = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

resource "digitalocean_firewall" "public" {
  name = "public"

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "22"
      source_tags = ["${var.ssh}"]
    }
  ]

  outbound_rule = "${local.outbound_rule}"
}

resource "digitalocean_firewall" "restricted" {
  name = "restricted"

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "443"
      source_tags = ["${var.public}", "${var.restricted}"]
    },
    {
      protocol = "tcp"
      port_range = "80"
      source_tags = ["${var.public}", "${var.restricted}"]
    },
    {
      protocol = "tcp"
      port_range = "22"
      source_tags = ["${var.ssh}"]
    }
  ]

  outbound_rule = "${local.outbound_rule}"
}

resource "digitalocean_firewall" "whitelist" {
  name = "whitelist"

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "1-65535"
      source_addresses = ["${var.whitelist_ips}"]
    }
  ]

  outbound_rule = "${local.outbound_rule}"
}
