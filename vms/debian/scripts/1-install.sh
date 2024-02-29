#!/usr/bin/env bash

# *** convenience install ***
curl -fsSL https://get.docker.com -o install-docker.sh
# sudo sh install-docker.sh --dry-run # FYI
sudo sh install-docker.sh --version 24.0.7
# FYI find versions with: `apt-cache madison docker-ce`, i.e. currently:
# debian:
#   23.0.0 => 23.0.6
#   24.0.0 => 24.0.9
#   25.0.0 => 25.0.3
# ubuntu
#   24.0.7 => 24.0.9
#   25.0.0 => 25.0.3

# *** post-install ***
sudo usermod -aG docker vagrant

sudo systemctl enable docker.service containerd.service
sudo systemctl start docker.service containerd.service

# *** completions ***
#   (generated vs manual) => fish generated are currently superior
mkdir -p /home/vagrant/.config/fish/completions
docker completion fish >/home/vagrant/.config/fish/completions/docker.fish
