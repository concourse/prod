resource "google_compute_target_pool" "algorithm-web" {
  name = "algorithm-web-target-pool"
  health_checks = ["${google_compute_http_health_check.algorithm-web.name}"]
}

resource "google_compute_forwarding_rule" "algorithm-web" {
  name = "algorithm-web-forwarding-rule"
  target = "${google_compute_target_pool.algorithm-web.self_link}"
  port_range = "1-65535"
}

resource "google_compute_firewall" "algorithm-web" {
  name = "algorithm-web-firewall"
  network = "${google_compute_network.bosh.name}"

  allow {
    protocol = "tcp"
    ports = ["80", "443", "2222"]
  }

  target_tags = ["algorithm-web"]
}

resource "google_compute_http_health_check" "algorithm-web" {
  name = "algorithm-web-health-check"
  port = 80
  request_path = "/api/v1/info"
  healthy_threshold = 1
  unhealthy_threshold = 10
}

resource "google_dns_record_set" "algorithm-concourse-ci-org-dns" {
  name = "algorithm.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.concourse-ci-org.name}"

  rrdatas = ["${google_compute_forwarding_rule.algorithm-web.ip_address}"]
}
