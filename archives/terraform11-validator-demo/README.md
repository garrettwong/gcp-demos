# Terraform Validator Demo

Demo, showcasing how to leverage terraform-validator in a simple bash pipeline.  This demo targets usage with terraform v0.11.x and the associated terraform-validator version.

## Scenarios

1. All GCS buckets deployed SHALL NOT be in the US
2. (TBD)

## Prerequisites

1. Terraform v0.11.x
2. terraform-validator

## Getting Started

Install terraform-validator for terraform v0.11.x:

```bash
gsutil cp gs://terraform-validator/releases/2019-03-28/terraform-validator-darwin-amd64 .
chmod +x terraaform-validator-darwin-amd64
```

```bash
# 1. Set your your application-default credentials to an account that has access to provision via terraform
gcloud auth application-default login
PROJECT_ID="sandbox-0700"

# 2. Initialize Terraform resources and modules
terraform init

# 3. Run Terraform Plan with an -out param
terraform plan -var-file="terraform.tfvars" -out my.tfplan

# 4. **Run Terraform Validator**
./terraform-validator-darwin-amd64 validate my.tfplan --project $PROJECT_ID --policy-path=../policy-library

# 5. Update the terraform.tfvars file
Location = "US" has been blacklisted and will be reported as a violation.

In order to bypass this, deploy the resource in an alternative region, for example, "asia-southeast1".  

To pass terraform-validator, comment out line, location="US",
and uncomment the line location="asia-southeast1"

# 6. Run Terraform Apply
terraform apply my.tfplan

# 6. Verify
gsutil ls -p $PROJECT_ID
```

## Demo Scripts

```bash
# 1. Update terraform.tfvars

# 2. Set your gcloud config project id (This is only for running the run_to_* scripts)
PROJECT_ID="[YOUR_PROJECT_ID]"
gcloud config set project $PROJECT_ID
./tf_validate.sh
./tf_apply.sh
```

## Demo: Updating Constraints

1. Constraints are located in the ../../policy-library - WHERE do we get this?

   `cat ../../policy-library/policies/constraints/storage_location.yaml` - BUCKETS are only allowed in ASIA-SOUTHEAST1?

2. Now... what if we update the bucket location to the US...

## Resources

- [Forseti Security Slides](https://docs.google.com/presentation/d/18HUHWppc4GFbK5fhe7kQfeOg_bk0XUzqTFG6v55XfVk/edit#slide=id.p)
- [Installing Terraform Validator](https://github.com/GoogleCloudPlatform/terraform-validator)
  - git clone and run `go install .` then copy the binary 'sudo cp terraform-validator /usr/local/bin/')
