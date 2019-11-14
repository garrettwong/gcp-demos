# GCS - Kitchen and Inspec

## Prerequisites

* Terraform v0.11.x (latest is v0.11.14)
* Ruby
* Inspec
* Kitchen-Terraform

## Getting Started

```bash
# you would need to install ruby first
gem install inspec -v 2.3.28 --no-document
gem install kitchen-terraform -v 4.8.1 --no-document

# inspec and kitchen need to be accessible via your PATH
```

## Running

```bash
kitchen list # overall status
kitchen create
kitchen converge
kitchen verify

# this will FAIL and is hard-coded to have buckets exist in us-central1
```

## References

* [Inspec GCP Resources](https://github.com/inspec/inspec-gcp/tree/master/docs/resources)
