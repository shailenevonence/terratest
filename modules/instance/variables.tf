variable "gcp_project_id" {
  description = "The ID of the GCP project in which these resources will be created."
  type = string
}

variable "instance_name" {
  description = "The Name to use for the Cloud Instance."
  type        = string
}

variable "machine_type" {
  description = "The Machine Type to use for the Cloud Instance."
  type        = string
}

variable "zone" {
  description = "The Zone to launch the Cloud Instance into."
  type        = string
}
