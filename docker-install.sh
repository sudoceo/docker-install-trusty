#!/bin/bash

echo -e ">>>>>>>>>> updating ... \n"

apt-get update

echo -e ">>>>>>>>>> OK, upgrading ... \n"

apt-get upgrade -y

echo -e ">>>>>>>>>> install build-essentials ... \n"

apt-get install build-essentials -y

echo -e ">>>>>>>>>> add Docker repo key ... \n"

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo -e ">>>>>>>>>> update Docker packages list ... \n"

if [ -f /etc/apt/sources.list.d/docker.list ]
then
    if grep "deb https://apt.dockerproject.org/repo ubuntu-trusty main" /etc/apt/sources.list.d/docker.list
    then
        echo "key already exists, exiting /etc/apt/sources.list.d/docker.list...."
        echo ""
    else
        sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
    fi
else
    #sudo mkdir -p /etc/apt/sources.list.d/docker.list
    sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'
fi

apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine
apt-get update

#### MAIN INSTALL and Launch #####
echo -e ">>>>>>>>>> installing aufs storage driver \n"

apt-get install -y linux-image-extra-$(uname -r)
apt-get update

echo -e ">>>>>>>>>> install Docker engine ... \n"

apt-get install -y docker-engine

echo -e ">>>>>>>>>> creating docker group and adding user... \n"

sudo usermod -aG docker ubuntu

echo -e ">>>>>>>>>> testing docker ... \n"

docker run hello-world

echo -n "Reboot? (y/n) "

read item

case "$item" in
    y|Y) echo "rebooting ..."
        reboot
        ;;
    n|N) echo "exiting ..."
        exit 0
        ;;
    *) echo "exiting ..."
        exit 0
        ;;
esac
