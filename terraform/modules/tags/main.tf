resource "digitalocean_tag" "external" {
  name = "external"
}


resource "digitalocean_tag" "internal" {
  name = "internal"
}

resource "digitalocean_tag" "ssh" {
  name = "ssh"
}

resource "digitalocean_tag" "whitelist" {
  name = "whitelist"
}
