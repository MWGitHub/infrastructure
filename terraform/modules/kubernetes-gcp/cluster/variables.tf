variable "master_authorized_networks" {
  type = "string"
  description = "CIDR block for external networks that can access the masters"
}

variable "region" {
  type = "string"
  description = "Region for the cluster."
  default = "us-east1"
}

variable "network_main_link" {
  type = "string"
  description = "Main network for all regions."
}

variable "subnetwork_east" {
  type = "string"
  description = "Subnetwork link for the us-east cluster."
}

variable "subnetwork_secondary_cluster_east" {
  type = "string"
  description = "Secodary subnetwork name for the east cluster."
}

variable "subnetwork_secondary_services_east" {
  type = "string"
  description = "Secodary subnetwork name for the east services."
}
