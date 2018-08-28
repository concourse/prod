output "director-ip" {
  value = "${google_compute_address.director.address}"
}

output "concourse-web-forward-ip" {
  value = "${google_compute_forwarding_rule.concourse-web.ip_address}"
}

output "wings-web-forward-ip" {
  value = "${google_compute_forwarding_rule.wings-web.ip_address}"
}

output "concourse-metrics-forward-ip" {
  value = "${google_compute_forwarding_rule.concourse-metrics.ip_address}"
}
