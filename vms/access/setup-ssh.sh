#!/usr/bin/env bash

# directly ssh to vagrant VMs
# - no longer have to `cd ubuntu; vagrant ssh` (slow)
# - instead `ssh ubuntu` anywhere (fast, especially w/ persistent connections)

# FYI if SSH stops working (hanging), i.e. after host reboot, your VM might have a new IP address assigned, just re-run this script to update the ssh config.

# understand what is going on:
#   cd ubuntu; vagrant ssh
#   now,
#      vagrant ssh-config
#      vagrant ssh-config > .\vagrant_config
#      ssh -F .\vagrant_config ubuntu
#      mv .\vagrant_config ~/.ssh/config.d/vagrants/ubuntu
#        ensure ~/.ssh/config has line: Include config.d/vagrants/*
#      ssh ubuntu

# directory to store vagrant related ssh config
mkdir -p ~/.ssh/config.d/vagrants

# warn if Include isn't in ~/.ssh/config:
if ! grep -q 'Include config.d/vagrants/*' ~/.ssh/config; then
  echo "FYI, manually run:"
  # includes vagrants dir in default ssh config:
  echo "  echo 'Include config.d/vagrants/*' >> ~/.ssh/config"
fi

echo "generating ssh config... be patient, this takes 5-10 seconds"

# ssh ubuntu
( 
  cd ../ubuntu
  # FYI if VM isn't created, this generates an empty file, so no harm
  vagrant ssh-config --host ubuntu >~/.ssh/config.d/vagrants/ubuntu
)

# ssh centos
( 
  cd ../centos
  vagrant ssh-config --host centos >~/.ssh/config.d/vagrants/centos
)

# ssh debian
( 
  cd ../debian
  vagrant ssh-config --host debian >~/.ssh/config.d/vagrants/debian
)
