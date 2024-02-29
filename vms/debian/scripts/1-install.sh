#!/usr/bin/env bash

# *** convenience install ***
curl -fsSL https://get.docker.com -o install-docker.sh
# sudo sh install-docker.sh --dry-run # FYI
sudo sh install-docker.sh --version 24.0.7
# FYI find versions with: `apt-cache madison docker-ce`, i.e. currently:
# docker-ce | 5:25.0.3-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages
# docker-ce | 5:25.0.2-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages
# docker-ce | 5:25.0.1-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages
# docker-ce | 5:25.0.0-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages
# docker-ce | 5:24.0.9-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages
# docker-ce | 5:24.0.8-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages
# docker-ce | 5:24.0.7-1~ubuntu.23.10~mantic | https://download.docker.com/linux/ubuntu mantic/stable arm64 Packages

# *** post-install ***
sudo usermod -aG docker vagrant

sudo systemctl enable docker.service containerd.service
sudo systemctl start docker.service containerd.service

# *** completions ***
#   (generated vs manual) => fish generated are currently superior
mkdir -p /home/vagrant/.config/fish/completions
docker completion fish >/home/vagrant/.config/fish/completions/docker.fish
