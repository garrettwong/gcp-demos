#!/bin/bash

set -x

PROJECT_ID=$(gcloud config get-value project)

function teardown() {
    FEED_ID="test-feed"
    
    gcloud pubsub subscriptions delete cai-rt-subscription \
    --project $PROJECT_ID
    
    gcloud asset feeds delete $FEED_ID \
    --project=$PROJECT_ID
    
    gcloud projects remove-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:service-$(gcloud projects describe $PROJECT_ID --format="get(projectNumber)")@gcp-sa-cloudasset.iam.gserviceaccount.com \
    --role=roles/cloudasset.serviceAgent
    
    gcloud pubsub topics delete cai-rt-feed --project $PROJECT_ID
    
    gcloud projects remove-iam-policy-binding $PROJECT_ID \
    --member "user:$(gcloud config get-value account)" \
    --role "roles/cloudasset.owner"
    
    gcloud services disable cloudasset.googleapis.com --project $PROJECT_ID
}

teardown
