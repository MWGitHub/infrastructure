resource "digitalocean_firewall" "restricted" {
  name = "restricted"
  tags = ["${var.restricted_tag}"]

  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["24.46.198.203"]
    source_tags = ["${var.restricted_tag}"]
  }
}
