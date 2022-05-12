/* storage_location: buckets only allowed in asia-southeast1 */
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "google_storage_bucket" "image-store" {
  count    = 1
  project  = var.project_id
  name     = format("%s-%s", "demo-bucket", element(random_id.bucket_suffix.*.hex, count.index))
  location = var.location

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

output "google_storage_bucket_image-store" {
  value = google_storage_bucket.image-store[0].name
}
