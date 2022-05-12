# Terraform v0.12.x Validator

Demo to get started with Terraform v0.12.x.

1. All GCS buckets deployed SHALL NOT be in the US
2. Restrict the application of particular IAAM roles

## Prerequisites

1. Terraform v0.12.x
2. This demo has been tuned for *Mac OSX*.  If using Linux or Windows, please download the respective `terraform` AND `terraform-validator` binaries.

## Getting Started

```bash
# 0. Download terraform and terraform-validator
./init.sh

# 1. Set your your application-default credentials to an account that has access to provision via terraform
gcloud auth application-default login
PROJECT_ID="sandbox-0700"

# 2. Initialize Terraform resources and modules
./terraform init
./terraform fmt

# 3. Run Terraform Plan with an -out param
./terraform plan -var-file="terraform.tfvars" -out my.tfplan

# 4. Convert binary plan file to json
./terraform show -json ./my.tfplan > ./my.tfplan.json

# 5. **Run Terraform Validator**
./terraform-validator-darwin-amd64 validate my.tfplan.json --policy-path ../policy-library

# 6. Run Terraform Apply
./terraform apply my.tfplan

# 6. Verify
gsutil ls -p $PROJECT_ID
```

## Demo

```bash
# 0. Download terraform and terraform-validator
./init.sh

# 1. Update terraform.tfvars

# 2. Set your gcloud config project id (This is only for running the run_to_* scripts)
PROJECT_ID="[YOUR_PROJECT_ID]"
gcloud config set project $PROJECT_ID
./run_to_validate.sh
./run_to_apply.sh

# 3. Update the Policy Library Constraints (../policy-library/policies/constraints/)
```

## Resources

- [Forseti Security Slides](https://docs.google.com/presentation/d/18HUHWppc4GFbK5fhe7kQfeOg_bk0XUzqTFG6v55XfVk/edit#slide=id.p)
- [Installing Terraform Validator](https://github.com/GoogleCloudPlatform/terraform-validator)
  - To run as `terraform-validator`, you'll have to move this to your /usr/local/bin/ directory via running `sudo cp terraform-validator /usr/local/bin/`.
