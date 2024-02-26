#!/usr/bin/env bash

# *** convenience install ***
curl -fsSL https://get.docker.com -o install-docker.sh
# sudo sh install-docker.sh --dry-run # FYI
sudo sh install-docker.sh



# *** post-install ***
sudo usermod -aG docker vagrant

sudo systemctl enable docker.service containerd.service
sudo systemctl start docker.service containerd.service



# *** completions ***
#   (generated vs manual) => fish generated are currently superior
docker completion fish > /home/vagrant/.config/fish/completions/docker.fish
