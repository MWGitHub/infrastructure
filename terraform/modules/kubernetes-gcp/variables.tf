variable project_id {
  type = "string"
  description = "Id of the GCP project."
}

variable "regions" {
  type = "list"
  description = "Regions for the clusters."
  default = ["us-east1", "us-west1"]
}
