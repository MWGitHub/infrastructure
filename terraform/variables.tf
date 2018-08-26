variable do_token {
  description = "The Digital Ocean token associated with the project."
}

variable whitelist_ips {
  type = "list"
  default = []
  description = "The IPs which can access restricted hosts."
}

variable admin_ips {
  type = "list"
  default = []
  description = "The IPs which have admin access and can open secure shells to resources."
}
