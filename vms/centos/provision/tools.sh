#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# dnf repolist
sudo dnf install -y epel-release
# bat found in epel via https://koji.fedoraproject.org/koji/packageinfo?packageID=27506
sudo dnf install -y jq \
  PackageKit-command-not-found \
  the_silver_searcher \
  tree \
  bat pipx \
  util-linux vim lsof \
  bash-completion \
  util-linux-user \
  curl wget \
  fish

# ensure install for vagrant user!
sudo -u vagrant pipx install icdiff
sudo -u vagrant pipx install oscclip
# pipx install grc # doesn't work? and warns about strec instead of grc

# append ~/.bashrc.mods to ~/.bashrc
echo "source /home/vagrant/.bashrc.mods" >>/home/vagrant/.bashrc

# silence
touch /home/vagrant/.hushlogin

# set fish shell as default shell for vagrant user
sudo chsh -s /usr/bin/fish vagrant # alt: /bin/bash
# util-linux-user provides chsh
