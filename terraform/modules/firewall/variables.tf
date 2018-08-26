variable "external" {
  description = "The tag for external"
}

variable "internal" {
  description = "The tag for the internal"
}

variable "ssh" {
  description = "The tag for ssh access"
}

variable "whitelist" {
  description = "The tag for whitelist"
}

variable "whitelist_ips" {
  type = "list"
  default = []
  description = "IPs allowed to access internal resources"
}
