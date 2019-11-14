#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)

terraform plan -var-file=terraform.tfvars -out my.tfplan

echo "Running terraform-validator..."
RES=$(terraform-validator validate my.tfplan --project $PROJECT_ID --policy-path=../policy-library/ 2> /dev/null)

if [ "$RES" = "No violations found." ]; then
    echo "Running terraform apply"
    
    terraform apply my.tfplan
else
    RED='\033[0;31m'
    NC='\033[0m'
    printf "${RED}Error: ${RES[@]}${NC}"
fi
