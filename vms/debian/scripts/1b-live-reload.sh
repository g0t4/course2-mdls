#!/usr/bin/env bash

echo
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
