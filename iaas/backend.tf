terraform {
  backend "gcs" {
    bucket = "concourse-tf-state"
    prefix = "terraform/state"
  }
}
