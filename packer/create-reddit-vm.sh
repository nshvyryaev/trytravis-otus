#!/bin/bash

gcloud compute instances create reddit-app-cli \
    --zone=europe-west1-b \
    --machine-type=f1-micro \
    --subnet=default \
    --restart-on-failure \
    --tags=puma-server \
    --image-family=reddit-full \
    --image-project=smooth-research-271409 \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard
