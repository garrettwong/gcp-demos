#!/bin/sh

## Mac OSX

# Get Terraform v0.12.14
curl -O https://releases.hashicorp.com/terraform/0.12.14/terraform_0.12.14_darwin_amd64.zip

unzip terraform_0.12.14_darwin_amd64.zip

chmod +x terraform

./terraform --version # should equal 0.12.14

rm terraform_0.12.14_darwin_amd64.zip



# Get Terraform Validator (https://github.com/forseti-security/policy-library/blob/master/docs/user_guide.md#how-to-use-terraform-validator)
gsutil cp gs://terraform-validator/releases/2019-11-07/terraform-validator-darwin-amd64 .
chmod 755 terraform-validator-darwin-amd64
