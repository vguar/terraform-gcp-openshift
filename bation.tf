resource "google_compute_instance" "bastion" {
  name         = "${var.prefix}-bastion"
  machine_type = "${var.machine_type}"
  zone         = "europe-west4-a"

  tags = ["${var.prefix}", "${var.prefix}-bastion"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size  = "${var.disk_size_gb}"
      type  = "${var.disk_type}"
    }
  }

  // Local SSD disk
  scratch_disk {}

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo      = "bar"
    ssh-keys = "cloud-user:${file(var.gcp_ssh_key)}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
