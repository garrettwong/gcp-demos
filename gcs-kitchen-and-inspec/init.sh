#!/bin/sh

PROJECT_ID="sandbox-0700"

gsutil mb -p $PROJECT_ID gs://garrettwong-terraform-testing
gcloud iam service-accounts create tf-project-account --project $PROJECT_ID

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:tf-project-account@$PROJECT_ID.iam.gserviceaccount.com \
    --role=roles/editor

