provider "google" {
  credentials = file("${path.module}/terraform.key.json")
  project = var.projectid
  region = var.region
}
