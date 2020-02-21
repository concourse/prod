resource "google_compute_target_pool" "concourse-metrics" {
  name = "concourse-metrics-target-pool"
  health_checks = []
}

resource "google_compute_forwarding_rule" "concourse-metrics" {
  name = "concourse-metrics-forwarding-rule"
  target = google_compute_target_pool.concourse-metrics.self_link
  port_range = "1-65535"
}

resource "google_compute_firewall" "concourse-metrics" {
  name = "concourse-metrics-firewall"
  network = google_compute_network.bosh.name

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  target_tags = ["concourse-metrics"]
}
