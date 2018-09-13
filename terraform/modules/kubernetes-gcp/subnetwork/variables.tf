variable "network_link" {
  type = "string"
  description = "Network the subnetwork is in."
}

variable "name" {
  type = "string"
  description = "Name of the subnet."
}

variable "cidr_range" {
  type = "string"
  description = "CIDR range for the subnet."
}

variable "region" {
  type = "string"
  description = "Region where the subnet resides."
}

variable "cluster_range" {
  type = "string"
  description = "CIDR range for the cluster."
}

variable "cluster_name" {
  type = "string"
  description = "Name of the cluster."
}

variable "service_range" {
  type = "string"
  description = "CIDR range for the service."
}

variable "service_name" {
  type = "string"
  description = "Name of the service."
}
