provider "google" {
  project_id = "${var.gcp_project_id}"
  zone = "${var.zone}"
}

module "test_instance" {
  source = "./modules/instance"

  instace_name   = "terratest-example"
  machine_type   = "f1-micro"
  instance_zone  = "${var.zone}"
  }

output "instance_name" {
  value = google_compute_instance.example.name
}

output "public_ip" {
  value = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}