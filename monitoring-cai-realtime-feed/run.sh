#!/bin/bash

set -x

PROJECT_ID=$(gcloud config get-value project)

function init() {
    gcloud services enable cloudasset.googleapis.com --project $PROJECT_ID
    
    gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member "user:$(gcloud config get-value account)" \
    --role "roles/cloudasset.owner"
    
    gcloud pubsub topics create cai-rt-feed --project $PROJECT_ID
    
    gcloud beta services identity create \
    --service=cloudasset.googleapis.com \
    --project=$PROJECT_ID
    
    gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:service-$(gcloud projects describe $PROJECT_ID --format="get(projectNumber)")@gcp-sa-cloudasset.iam.gserviceaccount.com \
    --role=roles/cloudasset.serviceAgent
    
    # create feed
    FEED_ID="test-feed"
    gcloud asset feeds create $FEED_ID \
    --project=$PROJECT_ID \
    --content-type=resource \
    --asset-types="storage.googleapis.com/Bucket" \
    --pubsub-topic="projects/$PROJECT_ID/topics/cai-rt-feed"
    
    gcloud asset feeds describe $FEED_ID --project=$PROJECT_ID
    
    gcloud pubsub subscriptions create cai-rt-subscription \
        --topic cai-rt-feed \
        --project $PROJECT_ID
}

init
