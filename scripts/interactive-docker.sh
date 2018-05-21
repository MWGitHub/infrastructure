#!/usr/bin/env bash

docker run -it --privileged --expose 8200 \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    --mount type=bind,source=/v/projects/infrastructure/terraform/network/vault/provisioner,target=/root/config \
    ubuntu:16.04
