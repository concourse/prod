resource "google_compute_firewall" "test" {
  name    = "${var.env_id}-test"
  network = "${google_compute_network.bbl-network.name}"

  source_ranges = ["0.0.0.0/0"]

  allow {
    ports    = ["8080"]
    protocol = "tcp"
  }

  target_tags = ["${var.env_id}-test"]
}

output "open_tag_name" {
  value = "${google_compute_firewall.test.name}"
}

resource "google_compute_firewall" "worker-to-director" {
  name    = "${var.env_id}-worker-to-director"
  network = "${google_compute_network.bbl-network.name}"

  source_tags = ["${var.env_id}-internal"]

  allow {
    ports    = ["22", "6868", "8443", "8844", "25555"]
    protocol = "tcp"
  }

  target_tags = ["${var.env_id}-bosh-director"]
}

resource "google_storage_bucket" "topgun-blobstore" {
  name = "topgun-blobstore"
}
