#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)

function init() {
    [ ! -d "policy-library" ] && git clone https://github.com/GoogleCloudPlatform/policy-library
}

init
terraform plan -var-file=terraform.tfvars -out my.tfplan
terraform show -json ./my.tfplan > ./tfplan.json
gcloud beta terraform vet tfplan.json --policy-library policy-library

VIOLATIONS=$(gcloud beta terraform vet tfplan.json --policy-library=policy-library --format=json)
retVal=$?
if [ $retVal -eq 2 ]; then
  # Optional: parse the VIOLATIONS variable as json and check the severity level
  echo "$VIOLATIONS"
  echo "Violations found; not proceeding with terraform apply"
  exit 1
fi
if [ $retVal -ne 0]; then
  echo "Error during gcloud beta terraform vet; not proceeding with terraform apply"
  exit 1
fi

echo "No policy violations detected; proceeding with terraform apply"

terraform apply --auto-approve

