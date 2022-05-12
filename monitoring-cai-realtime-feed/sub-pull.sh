#!/usr/bin/env bash

PROJECT_ID=$(gcloud config get-value project)

X=$(gcloud pubsub subscriptions pull cai-rt-subscription \
--project $PROJECT_ID \
--auto-ack \
--format=json)

if [[ "$X" == "[]" ]]; then 
    echo "Pub/Sub subscription is empty."
    exit 0
fi

RES=$(gcloud pubsub subscriptions pull cai-rt-subscription \
--project $PROJECT_ID \
--auto-ack \
--format=json \
| jq -r .[0].message.data | base64 -d)

function log_to_gcs() {
    LOCAL_FILE_PATH=$1
    gsutil mb gs://gwc-cai-rt-feed-results
    gsutil cp $LOCAL_FILE_PATH gs://gwc-cai-rt-feed-results
    rm $LOCAL_FILE_PATH
}

echo "$RES"
TEMP_FILE_NAME=$(date +%s)
echo "$RES" > ${TEMP_FILE_NAME}.json
log_to_gcs "${TEMP_FILE_NAME}.json"


printf "\n"