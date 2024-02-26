#!/usr/bin/env bash

# modify ~/.ssh/config
# ssh vagrant configs
trash ~/.ssh/config.d/vagrants
# trash = safe rm
# brew install trash

# docker contexts
docker context use desktop-linux
# docker context use default
docker context rm centos
docker context rm ubuntu
docker context rm debian
docker context ls

# optional, remove:
#    Include config.d/vagrants/*
#    from ~/.ssh/config
