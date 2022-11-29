variable "gcp_project_id" {
  description = "The ID of the GCP project in which these resources will be created."
  default = "infra-devops-experiments"
}

variable "zone" {
  description = "The Zone to launch the Cloud Instance into."
  type        = string
  default     = "us-central1-a"
}
