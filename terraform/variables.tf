variable do_token {
  description = "The Digital Ocean token associated with the project."
}

variable restricted_ips {
  type = "list"
  description = "The ips which can access restricted hosts."
}

variable ssh_ips {
  type = "list"
  description = "The ips which can SSH in to a host that allows it."
}
