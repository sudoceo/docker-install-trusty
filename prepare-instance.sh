#!/bin/bash

apt-get update
apt-get upgrade -y

if [ ! $# == 1 ]; then
  echo "Only one argument (new host name) allowed ..."
  exit
fi

echo ">>>>>> changing hostname ... "

hostnamectl set-hostname "$1"

echo ">>>>>> hostname changed to : $1"
