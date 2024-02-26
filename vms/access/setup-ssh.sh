#!/usr/bin/env bash

# directly ssh to vagrant VMs
# - no longer have to `cd ubuntu; vagrant ssh` (slow)
# - instead `ssh ubuntu` anywhere (fast, especially w/ persistent connections)

# FYI manually ensure line exists:
# echo "Include config.d/vagrants/*" >> ~/.ssh/config

ssh_vagrants=~/.ssh/config.d/vagrants
mkdir -p $ssh_vagrants

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
