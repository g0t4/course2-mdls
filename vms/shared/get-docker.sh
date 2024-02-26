#!/usr/bin/env bash

# convenience script
curl -fsSL https://get.docker.com -o install-docker.sh
# sudo sh install-docker.sh --dry-run # FYI
sudo sh install-docker.sh



# post-install steps
sudo usermod -aG docker vagrant

sudo systemctl enable docker.service containerd.service
sudo systemctl start docker.service containerd.service
