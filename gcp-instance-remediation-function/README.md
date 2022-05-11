# GCP Functions: Security Automation

GCPFunctionsX contains a set of Cloud Functions.  

As of now there are 3 primary categories of Cloud Functions:

1. Http triggered (with Serverless VPC access)
2. GCS triggered (used for SOAR automation)
3. Pub/Sub triggered (used for SOAR automation)

## Function Test URLs

For ease and simplicity, here is the list of all the cloud function urls.

### Pub/Sub

- PubSubResponder - handles soar related events such as instances that do not follow naming convention by deleting them automatically.  This depends on a Logging Sink

### GCS

* StorageDebugger - simple example of responding to a gcs object write event

## Looking for other functions?  

* i.e. The Cloud Asset Inventory and Cloud Scheduler auto-export to BigQuery function 

### Zip

```bash
zip -r ../code.zip . -x '*bin/*' -x '*obj/*'

# or to dir directly
zip -r ~/Git/[YOURPATH]/code.zip . -x '*bin/*' -x '*obj/*'
```

## References

* https://cloud.google.com/functions/docs/testing/test-http#functions-testing-http-example-csharp
* https://codelabs.developers.google.com/codelabs/cloud-functions-csharp#5

