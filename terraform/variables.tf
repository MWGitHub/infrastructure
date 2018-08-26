variable do_token {
  description = "The Digital Ocean token associated with the project."
}

variable whitelist_ips {
  type = "list"
  default = []
  description = "The IPs which can access restricted hosts."
}
