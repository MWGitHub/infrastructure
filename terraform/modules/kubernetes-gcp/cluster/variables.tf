variable "name" {
  type = "string"
  description = "Name of the cluster."
}

variable "region" {
  type = "string"
  description = "Region for the cluster."
}

variable "master_cidr" {
  type = "string"
  description = "Master ipv4 cidr block which must not overlap with any subnet in the cluster."
}

variable "network_link" {
  type = "string"
  description = "Main network for all regions."
}

variable "subnetwork_link" {
  type = "string"
  description = "Subnetwork link"
}

variable "subnetwork_secondary_cluster" {
  type = "string"
  description = "Secondary subnetwork name for the cluster."
}

variable "subnetwork_secondary_services" {
  type = "string"
  description = "Secondary subnetwork name for the services."
}
