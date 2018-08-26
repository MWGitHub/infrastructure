resource "digitalocean_firewall" "main" {
  name = "main"

  inbound_rule = [
    # public
    {
      protocol = "tcp"
      port_range = "443"
      source_tags = ["${var.public}"]
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    # restricted
    {
      protocol = "tcp"
      port_range = "443"
      source_addresses = []
      source_tags = ["${var.restricted}"]
      source_addresses = ["${var.restricted_ips}"]
    },
    {
      protocol = "tcp"
      port_range = "8000"
      source_tags = ["${var.restricted}"]
      source_addresses = ["${var.restricted_ips}"]
    },
    # ssh
    {
      protocol = "tcp"
      port_range = "22"
      source_tags = ["${var.ssh}"]
      source_addresses = ["${var.ssh_ips}"]
    }
  ]

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
