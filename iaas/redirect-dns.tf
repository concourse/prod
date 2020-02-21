resource "google_dns_managed_zone" "concourse-ci" {
  name = "concourse-ci"
  dns_name = "concourse.ci."
}
