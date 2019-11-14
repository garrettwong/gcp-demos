#
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

title "Retrieve GCS bucket and verify region"

gcp_project_id = ENV["GOOGLE_CLOUD_PROJECT"]
gcs_storage_bucket = "sandbox-0700-gcs-kitchen-and-inspec"
gcs_storage_bucket_region = "us-central1"

control "gcs" do
  impact 1.0
  title "Ensure gcs buckets have the correct properties in bulk."

  describe google_storage_bucket(name: gcs_storage_bucket) do
    it { should exist }
    its("name") { should eq gcs_storage_bucket }
    its("location") { should cmp gcs_storage_bucket_region }
  end
end
