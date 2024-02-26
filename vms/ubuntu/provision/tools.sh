#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt install -y \
  apt-file \
  bash-completion \
  bat jq \
  command-not-found \
  curl wget \
  fish pipx icdiff grc \
  iproute2 procps psmisc \
  silversearcher-ag tree \
  util-linux vim lsof

# ensure install for vagrant user!
sudo -u vagrant pipx install oscclip
# oscclip for copy to clipboard using OSC 52 escape sequences, i.e. over SSH with iterm2... not using paste (iterm2 prompts to allow paste)
# OSC 52 support: https://github.com/ojroques/vim-oscyank#vim-oscyank

# append ~/.bashrc.mods to ~/.bashrc
echo "source /home/vagrant/.bashrc.mods" >>/home/vagrant/.bashrc

# silence!
touch /home/vagrant/.hushlogin

# set fish shell as default shell for vagrant user
sudo chsh -s /usr/bin/fish vagrant # alt: /bin/bash
