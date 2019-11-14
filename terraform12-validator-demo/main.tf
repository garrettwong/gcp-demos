/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  # run provider as user
  project = var.project_id
}