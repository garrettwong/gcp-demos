/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  version = "~> 2.0, >= 2.5.1"
  alias   = "tokengen"
}

data "google_client_config" "default" {
  provider = "google.tokengen"
}

data "google_service_account_access_token" "sa" {
  provider               = "google.tokengen"
  target_service_account = "${var.terraform_service_account}"
  lifetime               = "1200s"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

/******************************************
  GA Provider configuration
 *****************************************/
provider "google" {
  version      = "~> 2.0, >= 2.5.1"
  access_token = "${data.google_service_account_access_token.sa.access_token}"
  project      = "${var.project_id}"
}

/******************************************
  Beta Provider configuration
 *****************************************/
provider "google-beta" {
  version      = "~> 2.0, >= 2.5.1"
  access_token = "${data.google_service_account_access_token.sa.access_token}"
  project      = "${var.project_id}"
}

/******************************************
   Provider backend store
  *****************************************/
terraform {
  backend "gcs" {
    bucket = "garrettwong-terraform-testing"
    prefix = "gcs-kitchen-and-inspec"
  }
}

data "google_project" "this" {
  project_id = "${var.project_id}"
}
