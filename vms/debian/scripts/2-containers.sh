#!/usr/bin/env bash

echo
echo "before 2-containers:"
docker container ls
echo
echo "/etc/docker/daemon.json:"
sudo cat /etc/docker/daemon.json
echo

echo configuring live restore:
sudo tee /etc/docker/daemon.json <<EOF
{
    "live-restore": true
}
EOF
dockerd --validate
# FYI changing from "live-restore": true => remove line (empty daemon.json) => reload won't work to disable live restore... not an issue other way around from empty => true/false
echo before reload:
docker info | grep "Live Restore"

sudo systemctl reload docker.service

echo after reload:
docker info | grep "Live Restore"

# emphermal container:
docker container run -d -p "10000:10000" --name=web envoyproxy/envoy:dev
docker container run -d -p "10001:10000" --name=web-rm --rm envoyproxy/envoy:dev
docker container run -d -p "10002:10000" --name=web-restarts --restart=always envoyproxy/envoy:dev
# FYI restart policy: https://docs.docker.com/reference/cli/docker/container/run/#restart

echo
echo "after 2-containers:"
docker container ls
echo
