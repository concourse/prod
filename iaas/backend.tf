terraform {
  backend "gcs" {
    credentials = "terraform.key.json"
    bucket = "concourse-tf-state"
    prefix = "terraform/state"
  }
}
