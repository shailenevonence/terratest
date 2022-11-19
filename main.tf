
# Generate a random string to append to resource names.
resource "random_string" "random" {
  length  = 6
  upper   = false
  special = false
}

# Creates a GCP Project.
resource "google_project" "demo_project" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_string.random.result}"
  org_id          = "1042453311661"
  billing_account = "01675F-850435-72830E"
  labels          = var.labels
}

# Enable services in newly created GCP Project.
resource "google_project_service" "gcp_services" {
  count   = length(var.gcp_service_list)
  project = google_project.demo_project.project_id
  service = var.gcp_service_list[count.index]

  disable_dependent_services = true
}

# Creates a GCS bucket to store tfstate.
resource "google_storage_bucket" "tfstate" {
  name     = "${google_project.demo_project.project_id}-tfstate"
  location = var.region
  project  = google_project.demo_project.project_id
}

#creating service account
resource "google_service_account" "service_account" {
  project = google_project.demo_project.project_id
  account_id   = "new-service-account-for-demo"
  display_name = "Service Account"
}

#creating VM instance
resource "google_compute_instance" "default" {
  project = google_project.demo_project.project_id
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = var.zone

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
}