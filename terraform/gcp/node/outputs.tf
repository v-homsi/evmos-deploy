output "node_ip" {
  value = google_compute_instance.evmos_node.network_interface.0.network_ip
}
