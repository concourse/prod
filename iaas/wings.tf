resource "google_compute_target_pool" "wings-web" {
  name = "wings-web-target-pool"
  health_checks = [google_compute_http_health_check.wings-web.name]
}

resource "google_compute_forwarding_rule" "wings-web" {
  name = "wings-web-forwarding-rule"
  target = google_compute_target_pool.wings-web.self_link
  port_range = "1-65535"
}

resource "google_compute_firewall" "wings-web" {
  name = "wings-web-firewall"
  network = google_compute_network.bosh.name

  allow {
    protocol = "tcp"
    ports = ["80", "443", "2222"]
  }

  target_tags = ["wings-web"]
}

resource "google_compute_http_health_check" "wings-web" {
  name = "wings-web-health-check"
  port = 80
  request_path = "/api/v1/info"
  healthy_threshold = 1
  unhealthy_threshold = 10
}
