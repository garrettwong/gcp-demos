#!/usr/bin/env bash

for i in {1..5}
do
    gsutil mb gs://ilovecookies-${i} &
    # gsutil cp run.sh gs://ilovecookies-${i} &
    sleep 0.1
done

sleep 5

for i in {1..5}
do
    gsutil rm -rf gs://ilovecookies-${i} &
done