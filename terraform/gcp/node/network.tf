resource "google_compute_network" "evmos_network" {
  name                    = var.network_prefix
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "evmos_subnetwork" {
  name                     = "${var.network_prefix}-sub"
  ip_cidr_range            = "10.126.0.0/20"
  network                  = google_compute_network.evmos_network.self_link
  region                   = var.region
  private_ip_google_access = true
}


resource "google_compute_firewall" "evmos-firewall" {
  depends_on = [google_compute_subnetwork.evmos_subnetwork]

  name    = "${var.network_prefix}-firewall"
  network = google_compute_network.evmos_network.name

  allow {
    protocol = "tcp"
    ports    = ["26657"]
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "tcp"
    ports    = ["26660"]
  }
  allow {
    protocol = "tcp"
    ports    = ["8545"]
  }
  allow {
    protocol = "icmp"
  }

  // Allow traffic from everywhere to instances with tag
  source_ranges = ["0.0.0.0/0"]
}
