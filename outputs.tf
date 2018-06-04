output external_ip_master {
  description = "The external IP assigned to the global fowarding rule for Master."
  value       = "${google_compute_global_address.master-lb-address.address}"
}

output external_ip_infra {
  description = "The external IP assigned to the global fowarding rule for Infra Node."
  value       = "${google_compute_global_address.infra-lb-address.address}"
}

output external_ip_node {
  description = "The external IP assigned to the global fowarding rule Applications Node."
  value       = "${google_compute_global_address.node-lb-address.address}"
}
