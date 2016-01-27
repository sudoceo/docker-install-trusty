#!/bin/bash
#################################
# Author: Valentine C. Nwachukwu
# Email: valdiz777@gmail.com
# Info: https://docs.docker.com/engine/installation/ubuntulinux/
# DESC: This is a Docker setup script for Ubuntu 14.04 LTS

sudo apt-get update && sudo apt-get dist-upgrade -yes
sudo apt-get install build-essentials -yes



############### Pre-Reqs ########
echo "Add docker key to apt"
echo "====================="
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

###### Create and Clean  ########
echo "Update docker.list"
echo "=================="

if [ -e /etc/apt/sources.list.d/docker.list ]
then
    if grep "deb https://apt.dockerproject.org/repo ubuntu-trusty main" /etc/apt/sources.list.d/docker.list
    then
        echo "key already exists, exiting /etc/apt/sources.list.d/docker.list...."
        echo ""
    else
        sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
    fi
else
    sudo mkdir -p /etc/apt/sources.list.d/docker.list
    sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
fi

sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get update

#### MAIN INSTALL and Launch #####
echo "installing aufs storage driver"
echo "=============================="
sudo apt-get install --yes linux-image-extra-$(uname -r)
sudo apt-get update
sudo apt-get install --yes docker-engine
echo "Starting docker service...."
echo "==========================="
sudo service docker start
echo "Verifying installation ....."
echo "============================"
sudo docker run hello-world
echo "Creating docker group and adding user..."
echo "========================================"
sudo usermod -aG docker ubuntu
su -c 'newgrp docker; while true; do sleep 1; done' user
echo "Verifying group addition"
echo "========================"
docker run hello-world
