resource "digitalocean_tag" "public" {
  name = "public"
}


resource "digitalocean_tag" "restricted" {
  name = "restricted"
}

resource "digitalocean_tag" "ssh" {
  name = "ssh"
}
