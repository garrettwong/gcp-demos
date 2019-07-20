locals {
  project_id = "${var.project_id}"
  location   = "${var.location}"
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  # run provider as user
  project = "${local.project_id}"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

/* iam_restrict_role: no roles/owner */
resource "google_project_iam_member" "project" {
  project = "${local.project_id}"
  role    = "roles/owner"
  member  = "user:garrettwong@example.com"
}
/* ./ iam_restrict_role: no roles/owner */

/* storage_location: buckets only allowed in asia-southeast1 */
resource "google_storage_bucket" "image-store" {
  name     = "${format("%s-%s", "demo-bucket", element(random_id.bucket_suffix.*.hex, count.index))}"
  location = "${local.location}"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
output "google_storage_bucket_image-store" {
  value = "${google_storage_bucket.image-store.name}"
}

/* ./ storage_location: buckets only allowed in asia-southeast1 */
