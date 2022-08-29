data "google_compute_image" "evmos_base_image" {
  family  = "evmos-testnet"
  project = "indigo-port-358902"
}

data "google_compute_zones" "available" {
  region = var.region
}

resource "google_compute_instance" "evmos_node" {
  name        = "${var.network_prefix}-fullnode"
  description = "This template is used to create evmos nodes"
  zone        = data.google_compute_zones.available.names[0]

  machine_type   = var.machine_type
  can_ip_forward = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  boot_disk {
    initialize_params {
      size  = 60
      image = data.google_compute_image.evmos_base_image.self_link
    }
  }

  network_interface {
    network    = google_compute_network.evmos_network.self_link
    subnetwork = google_compute_subnetwork.evmos_subnetwork.self_link
    access_config {}
  }

  lifecycle {
    create_before_destroy = true
  }

  service_account {
    email  = ""
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<SCRIPT
    export HOME=/root
    bash /evmosd/scripts/initialize.sh
    SCRIPT
}
