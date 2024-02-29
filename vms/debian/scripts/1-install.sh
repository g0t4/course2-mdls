#!/usr/bin/env bash

# *** convenience install ***
curl -fsSL https://get.docker.com -o install-docker.sh

# sudo sh install-docker.sh --dry-run # FYI

# FYI find versions with: `apt-cache madison docker-ce`, i.e. currently:
# debian:
#   23.0.0 => 23.0.6
#   24.0.0 => 24.0.9
#   25.0.0 => 25.0.3
# ubuntu
#   24.0.7 => 24.0.9
#   25.0.0 => 25.0.3
sudo sh install-docker.sh --version 23.0.6
# sudo sh install-docker.sh --version 24.0.7
# *** logs from `install-docker.sh --version 24.0.7` => what was run (with sudo):
# sh -c apt-get update -qq >/dev/null
# sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
# sh -c install -m 0755 -d /etc/apt/keyrings
# sh -c curl -fsSL "https://download.docker.com/linux/debian/gpg" | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
# sh -c chmod a+r /etc/apt/keyrings/docker.gpg
# sh -c echo "deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list
# sh -c apt-get update -qq >/dev/null
# sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq docker-ce=5:24.0.7-1~debian.12~bookworm docker-ce-cli=5:24.0.7-1~debian.12~bookworm containerd.io docker-compose-plugin docker-ce-rootless-extras=5:24.0.7-1~debian.12~bookworm docker-buildx-plugin >/dev/null
# sh -c docker version
# /lib/systemd/systemd-sysv-install enable docker

# *** post-install ***
sudo usermod -aG docker vagrant

sudo systemctl enable docker.service containerd.service
sudo systemctl start docker.service containerd.service

# *** completions ***
#   (generated vs manual) => fish generated are currently superior
mkdir -p /home/vagrant/.config/fish/completions
docker completion fish >/home/vagrant/.config/fish/completions/docker.fish
