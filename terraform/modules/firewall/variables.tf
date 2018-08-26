variable "public" {
  description = "The tag for public"
}


variable "restricted" {
  description = "The tag for the restricted"
}

variable "ssh" {
  description = "The tag for ssh access"
}

variable "restricted_ips" {
  type = "list"
  default = []
  description = "IPs allowed to access restricted hosts"
}

variable "ssh_ips" {
  type = "list"
  default = []
  description = "IP addresses for sshing into a host"
}
