variable project_id {
  type = "string"
  description = "Id of the GCP project."
}

variable region {
  type = "string"
  description = "Region to use."
}

variable "master_authorized_networks" {
  type = "string"
  description = "CIDR block for external networks that can access the masters"
}
