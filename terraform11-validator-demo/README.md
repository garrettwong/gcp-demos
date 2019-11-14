# Terraform - Config Validator Demo

A simple set of demos, showcasing a few use cases around using terraform-validator:

1. All GCS buckets deployed SHALL NOT be in the US
2. (TBD)

## Prerequisites

1. Terraform v0.12.x

## Getting Started

```bash
# 1. Set your your application-default credentials to an account that has access to provision via terraform
gcloud auth application-default login
PROJECT_ID="sandbox-0700"

# 2. Initialize Terraform resources and modules
terraform init

# 3. Run Terraform Plan with an -out param
terraform plan -var-file="terraform.tfvars" -out my.tfplan

# 4. **Run Terraform Validator**
terraform-validator validate my.tfplan --project $PROJECT_ID --policy-path=../policy-library

# 5. Run Terraform Apply
terraform apply my.tfplan

# 6. Verify
gsutil ls -p $PROJECT_ID
```

## Demo

```bash
# 1. Update terraform.tfvars

# 2. Set your gcloud config project id (This is only for running the run_to_* scripts)
PROJECT_ID="[YOUR_PROJECT_ID]"
gcloud config set project $PROJECT_ID
./run_to_validate.sh
./run_to_apply.sh
```

## Updating a Constraint

1. Constraints are located in the ../../policy-library - WHERE do we get this?

   `cat ../../policy-library/policies/constraints/storage_location.yaml` - BUCKETS are only allowed in ASIA-SOUTHEAST1?

2. Now... what if we update the bucket location to the US...

## Resources

- [Forseti Security Slides](https://docs.google.com/presentation/d/18HUHWppc4GFbK5fhe7kQfeOg_bk0XUzqTFG6v55XfVk/edit#slide=id.p)
- [Installing Terraform Validator](https://github.com/GoogleCloudPlatform/terraform-validator)
  - git clone and run `go install .` then copy the binary 'sudo cp terraform-validator /usr/local/bin/')
