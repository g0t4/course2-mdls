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

# FYI manually ensure line exists:
# echo "Include config.d/vagrants/*" >> ~/.ssh/config

ssh_vagrants="$HOME/.ssh/config.d/vagrants"
mkdir -p $ssh_vagrants

echo "generating ssh config... be patient, this takes 5-10 seconds"

# ssh ubuntu
( 
  cd ../ubuntu
  vagrant ssh-config --host ubuntu >$ssh_vagrants/ubuntu
)

# ssh centos
( 
  cd ../centos
  vagrant ssh-config --host centos >$ssh_vagrants/centos
)

# ssh debian
( 
  cd ../debian
  vagrant ssh-config --host debian >$ssh_vagrants/debian
)
