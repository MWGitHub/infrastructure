variable "public" {
  description = "The tag for public"
}

variable "restricted" {
  description = "The tag for the restricted"
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
