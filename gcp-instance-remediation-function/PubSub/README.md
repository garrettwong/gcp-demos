# GCP Functions: PubSub

## Deployments

### PubSub Publisher

gcloud functions deploy pubsub-message-publisher --entry-point GCPFunctionsX.MessagePublisher --runtime dotnet3 --trigger-http --allow-unauthenticated

### PUBSUB: Hello Pub/Sub debugger

gcloud functions deploy hello-cloudevent-pubsub-function2 --runtime dotnet3 --entry-point HelloCloudEventPubSubFunction.Function --trigger-topic cloud-functions-topic --allow-unauthenticated

### PUBSUB: Responder

gcloud functions deploy pubsub-responder --runtime dotnet3 --entry-point GCPFunctionsX.PubSubResponder --trigger-topic cloud-functions-topic --allow-unauthenticated

### Firewall Destroyer

gcloud functions deploy firewall-destroyer --runtime dotnet3 --entry-point GCPFunctionsX.FirewallDestroyer --trigger-topic cloud-functions-topic --quiet

## Testing

### PUBSUB VERIFY

TOPIC_NAME="cloud-functions-topic"
for i in {1..5};
do
gcloud pubsub topics publish ${TOPIC_NAME} --message="Hello World ${i}"
done

for i in {1..5};
do
gcloud functions logs read hello-cloudevent-pubsub-function
done

### PUBSUB INSTANCE FIND AND DELETE FUNCTION. Create 25 instances, because they contain the word instance in it, they should be deleted.

```bash
#!/usr/bin/env bash
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="get(projectNumber)")
for i in {1..25};
do
    gcloud beta compute --project=$PROJECT_ID instances create instance-${i} --zone=us-central1-a --machine-type=e2-medium --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=debian-10-buster-v20210512 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-balanced --boot-disk-device-name=instance-1 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any &
sleep 0.5
done
```
