resource "digitalocean_firewall" "restricted" {
  name = "restricted"
  tags = ["${var.restricted_tag}"]

  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["24.46.198.203"]
    source_tags = ["${var.restricted_tag}"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "icmp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
