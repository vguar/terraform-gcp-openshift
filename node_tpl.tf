resource "google_compute_instance_template" "node_tpl" {
  name        = "${var.prefix}-node-template"
  description = "This template is used to create node instances."

  tags = ["${var.prefix}", "${var.prefix}-node"]

  labels = {
    environment = "dev"
  }

  instance_description = "Openshift Node for ${var.prefix}"
  machine_type         = "${var.machine_type}"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = "${var.image}"
    auto_delete  = true
    boot         = true
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
  }

  network_interface {
    network = "default"
  }

  metadata {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }
}

resource "google_compute_region_instance_group_manager" "node_instance_group_manager" {
  name               = "${var.prefix}-node"
  instance_template  = "${google_compute_instance_template.node_tpl.self_link}"
  base_instance_name = "${var.prefix}-node"
  region             = "${var.region}"
  target_size        = "${var.num_nodes}"
  target_pools       = ["${google_compute_target_pool.node-pool.self_link}"]
}

// Creation du Loadbalencer
resource "google_compute_global_address" "node-lb-address" {
  name = "${var.prefix}-lb-node"
}

resource "google_compute_http_health_check" "node-healthcheck" {
  name               = "node-healthcheck"
  request_path       = "/"
  check_interval_sec = 30
  timeout_sec        = 10
}

resource "google_compute_target_pool" "node-pool" {
  name          = "${var.prefix}-lb-node"
  health_checks = ["${google_compute_http_health_check.node-healthcheck.name}"]
}

resource "google_compute_forwarding_rule" "node-https-lb" {
  name   = "${var.prefix}-front-lb-node"
  target = "${google_compute_target_pool.node-pool.self_link}"

  //ip_address = "${google_compute_global_address.node-lb-address.address}"
  port_range = "443"
  depends_on = ["google_compute_global_address.node-lb-address"]
  port_range = "443"
}
