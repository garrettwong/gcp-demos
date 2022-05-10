#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)

function init() {
    [ ! -d "policy-library" ] && git clone https://github.com/GoogleCloudPlatform/policy-library
}

init
terraform plan -var-file=terraform.tfvars -out my.tfplan
terraform destroy --auto-approve
