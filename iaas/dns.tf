resource "google_dns_managed_zone" "concourse-ci-org" {
  name = "concourse-ci-org"
  dns_name = "concourse-ci.org."
}

resource "google_dns_managed_zone" "concourse-ci-net" {
  name = "concourse-ci-net"
  dns_name = "concourse-ci.net."
}

resource "google_dns_managed_zone" "concourse-ci-com" {
  name = "concourse-ci-com"
  dns_name = "concourse-ci.com."
}

resource "google_dns_record_set" "concourse-ci-org-dns" {
  name = google_dns_managed_zone.concourse-ci-org.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["185.199.108.153", "185.199.109.153", "185.199.110.153", "185.199.111.153"]
}

resource "google_dns_record_set" "www-concourse-ci-org-dns" {
  name = "www.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["185.199.108.153", "185.199.109.153", "185.199.110.153", "185.199.111.153"]
}

resource "google_dns_record_set" "drills-concourse-ci-org-dns" {
  name = "drills.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = [google_compute_forwarding_rule.drills-web.ip_address]
}

resource "google_dns_record_set" "bosh-concourse-ci-org-dns" {
  name = "bosh.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = [google_compute_address.director.address]
}

resource "google_dns_record_set" "discuss-concourse-ci-org-dns" {
  name = "discuss.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["concourseci1.hosted-by-discourse.com."]
}

resource "google_dns_record_set" "blog-concourse-ci-org-dns" {
  name = "blog.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["concourse.ghost.io."]
}

resource "google_dns_record_set" "vault-concourse-ci-org-dns" {
  name = "vault.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["10.3.0.2"]
}

resource "google_dns_record_set" "telemetry-concourse-ci-org-dns" {
  name = "telemetry.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["concourse-telemetry.cfapps.io."]
}

resource "google_dns_record_set" "project-concourse-ci-org-dns" {
  name = "project.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["35.241.0.130"]
}

resource "google_dns_record_set" "dutyfree-concourse-ci-org-dns" {
  name = "resource-types.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["34.107.223.37"]
}

resource "google_dns_record_set" "hangar-concourse-ci-org-dns" {
  name = "hangar.${google_dns_managed_zone.concourse-ci-org.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.concourse-ci-org.name

  rrdatas = ["34.102.213.12"]
}
