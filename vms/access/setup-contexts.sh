#!/usr/bin/env bash

# docker contexts
docker context create ubuntu --docker="host=ssh://ubuntu"
docker context create centos --docker="host=ssh://centos"
docker context create debian --docker="host=ssh://debian"
echo
docker context ls
