resource "google_storage_bucket" "gcs-storage-bucket" {
  name     = "${var.project_id}-gcs-kitchen-and-inspec"
  location = "${var.region}"
}

output "google_storage_bucket_name" {
  value = "${google_storage_bucket.gcs-storage-bucket.name}"
}
