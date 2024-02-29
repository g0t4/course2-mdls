#!/usr/bin/env bash

echo
echo "before 2-containers:"
docker container ls
echo

# emphermal container:
docker container run -d -p "10000:10000" --name=web envoyproxy/envoy:dev
docker container run -d -p "10001:10000" --name=web-rm --rm envoyproxy/envoy:dev
docker container run -d -p "10002:10000" --name=web-restarts --restart=always envoyproxy/envoy:dev
# FYI restart policy: https://docs.docker.com/reference/cli/docker/container/run/#restart


echo
echo "after 2-containers:"
docker container ls
echo