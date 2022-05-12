#!/bin/sh

terraform destroy --auto-approve
rm -rf .terraform
rm terraform.tfplan*
rm terraform.tfstate*