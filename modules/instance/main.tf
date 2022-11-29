resource "google_compute_instance" "example" {
  project      = var.gcp_project_id
  name         = var.instance_name
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}