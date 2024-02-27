#!/usr/bin/env bash

# directly ssh to vagrant VMs
# - no longer have to `cd ubuntu; vagrant ssh` (slow)
# - instead `ssh ubuntu` anywhere (fast, especially w/ persistent connections)

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

# add to default SSH config
# echo "Include config.d/vagrants/*" >> ~/.ssh/config

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
