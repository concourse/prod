resource "google_compute_target_pool" "ephemeral-check-web" {
  name = "ephemeral-check-web-target-pool"
  health_checks = ["${google_compute_http_health_check.ephemeral-check-web.name}"]
}

resource "google_compute_forwarding_rule" "ephemeral-check-web" {
  name = "ephemeral-check-web-forwarding-rule"
  target = "${google_compute_target_pool.ephemeral-check-web.self_link}"
  port_range = "1-65535"
}

resource "google_compute_firewall" "ephemeral-check-web" {
  name = "ephemeral-check-web-firewall"
  network = "${google_compute_network.bosh.name}"

  allow {
    protocol = "tcp"
    ports = ["80", "443", "2222"]
  }

  target_tags = ["ephemeral-check-web"]
}

resource "google_compute_http_health_check" "ephemeral-check-web" {
  name = "ephemeral-check-web-health-check"
  port = 80
  request_path = "/api/v1/info"
  healthy_threshold = 1
  unhealthy_threshold = 10
}

resource "google_dns_record_set" "ephemeral-check-concourse-ci-org-dns" {
  name = "ephemeral-check.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.concourse-ci-org.name}"

  rrdatas = ["${google_compute_forwarding_rule.ephemeral-check-web.ip_address}"]
}
