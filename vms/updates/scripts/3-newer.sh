#!/usr/bin/env bash

sudo apt-get update

# apt-cache madison docker-ce
VERSION_STRING="5:24.0.9-1~debian.12~bookworm"
sudo apt-get install -y docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

docker version
docker container ps -a
