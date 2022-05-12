/* iam_restrict_role: no roles/owner */
resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = var.role_to_assign
  member  = "user:user@organization.com.com"
}

/* ./ iam_restrict_role: no roles/owner */

