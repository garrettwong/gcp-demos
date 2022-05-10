# Terraform - Config Validator Demo

A simple set of demos, showcasing a few use cases around using `gcloud terraform vet`:

1. All GCS buckets deployed SHALL NOT be in the US
2. Change the property, ".parameters.locations" in policy-library/constraints/storage_location.yaml to 'US' to allow bucket deploy

```bash
cat > policy-library/constraints/storage_location.yaml <<EOF
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
apiVersion: constraints.gatekeeper.sh/v1alpha1
kind: GCPStorageLocationConstraintV1
metadata:
  name: allow_some_storage_location
  annotations:
    description: Checks Cloud Storage bucket locations against allowed or disallowed
      locations.
    bundles.validator.forsetisecurity.org/healthcare-baseline-v1: security
spec:
  severity: high
  match:
    target: # {"$ref":"#/definitions/io.k8s.cli.setters.target"}
    - "organizations/**"
  parameters:
    mode: "allowlist"
    locations:
    - asia-southeast1
    exemptions: []

EOF
```

## Getting Started

1. Set your your application-default credentials to an account that has access to provision via terraform

    ```gcloud auth application-default login```

2. **Run Terraform Vet**

    ```./apply.sh```

3. Verify

    ```gsutil ls -p $PROJECT_ID```

4. Destroy

  ```./destroy.sh```

## Package

Zip
```zip -r tfdemo.zip .```

## Updating a Constraint

1. Constraints are located in the ../../policy-library - WHERE do we get this?

    ```cat ../../policy-library/policies/constraints/storage_location.yaml``` - BUCKETS are only allowed in ASIA-SOUTHEAST1?

2. Now... what if we update the bucket location to the US...

## References

## Resources

* https://cloud.google.com/docs/terraform/policy-validation/validate-policies

### Legacy

* [Forseti Security Slides](https://docs.google.com/presentation/d/18HUHWppc4GFbK5fhe7kQfeOg_bk0XUzqTFG6v55XfVk/edit#slide=id.p)
* [Installing Terraform Validator](https://github.com/GoogleCloudPlatform/terraform-validator)
  * git clone and run `go install .` then copy the binary 'sudo cp terraform-validator /usr/local/bin/')

```bash

RES=$(terraform-validator validate my.tfplan --project $PROJECT_ID --policy-path=../../policy-library/ 2> /dev/null)
echo $RES

if [ "$RES" = "No violations found." ]; then
    terraform apply my.tfplan
else
    RED='\033[0;31m'
    NC='\033[0m'
    printf "${RED}Error: ${RES[@]}${NC}"
fi

```