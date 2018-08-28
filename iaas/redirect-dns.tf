resource "google_dns_managed_zone" "concourse-ci" {
  name = "concourse-ci"
  dns_name = "concourse.ci."
}

resource "google_dns_record_set" "concourse-ci-dns" {
  name = "${google_dns_managed_zone.concourse-ci.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.concourse-ci.name}"

  rrdatas = ["52.45.157.165", "52.0.64.244"]
}

resource "google_dns_record_set" "www-concourse-ci-dns" {
  name = "www.${google_dns_managed_zone.concourse-ci.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.concourse-ci.name}"

  rrdatas = ["concourse.ci-e136802e.ssl.run.pivotal.io."]
}
