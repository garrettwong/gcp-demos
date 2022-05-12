#!/usr/bin/env bash


PROJECT_ID=$(gcloud config get-value project)

while true
do
    ./sub-pull.sh
    
    printf "\n"
    
    sleep 5
done