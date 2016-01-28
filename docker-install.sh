#!/bin/bash
#################################
# Author: Valentine C. Nwachukwu
# Email: valdiz777@gmail.com
# Info: https://docs.docker.com/engine/installation/ubuntulinux/
# DESC: This is a Docker setup script for Ubuntu 14.04 LTS

apt-get update

echo ">>>>>>>>>> upgrading ... \n"

apt-get upgrade -y

echo ">>>>>>>>>> install build-essentials ... \n"

apt-get install build-essentials -y

echo ">>>>>>>>>> add Docker repo key ... \n"

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo ">>>>>>>>>> update Docker packages list ... \n"

if [ -f /etc/apt/sources.list.d/docker.list ]
then
    if grep "deb https://apt.dockerproject.org/repo ubuntu-trusty main" /etc/apt/sources.list.d/docker.list
    then
        echo "key already exists, exiting /etc/apt/sources.list.d/docker.list...."
        echo ""
    else
        sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
    fi
else
    #sudo mkdir -p /etc/apt/sources.list.d/docker.list
    sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
fi

apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine
apt-get update

#### MAIN INSTALL and Launch #####
echo ">>>>>>>>>> installing aufs storage driver \n"

apt-get install -y linux-image-extra-$(uname -r)
apt-get update

echo ">>>>>>>>>> install Docker engine ... \n"

apt-get install -y docker-engine

echo ">>>>>>>>>> creating docker group and adding user... \n"

sudo usermod -aG docker ubuntu

echo ">>>>>>>>>> testing docker ... \n"

docker run hello-world
