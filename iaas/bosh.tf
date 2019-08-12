resource "google_compute_network" "bosh" {
  name = "bosh"
  auto_create_subnetworks = "false"
}

resource "google_compute_address" "director" {
  name = "director"
}

resource "google_compute_subnetwork" "director" {
  name          = "director"
  ip_cidr_range = "10.0.0.0/24"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "internal" {
  name          = "internal"
  ip_cidr_range = "10.1.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "metrics" {
  name          = "metrics"
  ip_cidr_range = "10.2.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "vault" {
  name          = "vault"
  ip_cidr_range = "10.3.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "internal-wings-credhub" {
  name          = "internal-wings-credhub"
  ip_cidr_range = "10.5.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "windows" {
  name          = "windows"
  ip_cidr_range = "10.95.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "test" {
  name          = "test"
  ip_cidr_range = "10.244.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_subnetwork" "topgun" {
  name          = "topgun"
  ip_cidr_range = "10.234.0.0/16"
  network       = "${google_compute_network.bosh.self_link}"
}

resource "google_compute_firewall" "bosh-director" {
  name    = "bosh-director"
  network = "${google_compute_network.bosh.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6868", "25555", "8443", "8844"]
  }

  target_tags = ["director"]
}

resource "google_compute_firewall" "bosh-internal" {
  name    = "bosh-internal"
  network = "${google_compute_network.bosh.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  target_tags = ["internal", "director"]
  source_tags = ["internal", "director", "nat", "vault"]
}

resource "google_compute_firewall" "concourse-vault" {
  name    = "concourse-vault"
  network = "${google_compute_network.bosh.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  target_tags = ["vault"]
  source_tags = ["concourse-web", "director", "internal"]
}

resource "google_compute_instance" "nat" {
  name = "nat"
  machine_type = "custom-1-1024"
  zone = "${var.zone}"
  can_ip_forward = true
  tags = ["nat"]

  boot_disk {
    initialize_params {
      image = "debian-8-jessie-v20160126"
      size = "10"
    }
  }

  metadata_startup_script = <<EOF
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
EOF

  network_interface {
    subnetwork = "${google_compute_subnetwork.internal.name}"
    access_config {
      # Ephemeral IP
    }
  }
}

resource "google_compute_route" "internal_nat" {
  name = "internal-nat-route"
  dest_range = "0.0.0.0/0"
  network = "${google_compute_network.bosh.name}"
  next_hop_instance = "${google_compute_instance.nat.name}"
  next_hop_instance_zone = "${google_compute_instance.nat.zone}"
  priority = 800
  tags = ["internal"]
}

resource "google_compute_route" "vault_nat" {
  name = "vault-nat-route"
  dest_range = "0.0.0.0/0"
  network = "${google_compute_network.bosh.name}"
  next_hop_instance = "${google_compute_instance.nat.name}"
  next_hop_instance_zone = "${google_compute_instance.nat.zone}"
  priority = 800
  tags = ["vault"]
}

resource "google_compute_firewall" "public_nat" {
  name    = "public-nat"
  network = "${google_compute_network.bosh.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  target_tags = ["nat"]
}
