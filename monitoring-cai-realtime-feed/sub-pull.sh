#!/usr/bin/env bash


PROJECT_ID=$(gcloud config get-value project)

gcloud pubsub subscriptions pull cai-rt-subscription \
--project $PROJECT_ID \
--auto-ack \
--format=json \
| jq -r .[0].message.data | base64 -d

printf "\n"