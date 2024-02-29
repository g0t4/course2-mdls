#!/usr/bin/env bash

sudo apt-get update

# upgrade to latest:
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker version
docker container ps -a

# upgrade docs:
# - https://docs.docker.com/engine/install/debian/#upgrade-docker-engine
