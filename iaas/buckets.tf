resource "google_storage_bucket" "concourse_media_assets" {
  name     = "concourse-media-assets"
  location = "US"
}

resource "google_storage_bucket_iam_member" "public_assets" {
  bucket = google_storage_bucket.concourse_media_assets.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
