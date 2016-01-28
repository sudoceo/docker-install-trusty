#!/bin/bash

if [ ! $# == 1 ]; then
  echo "Only one argument (new host name) allowed ..."
  exit
fi

echo ">>>>>> changing hostname ... "

hostnamectl set-hostname "$1"

echo "127.0.0.1 $1" >> /etc/hosts


echo ">>>>>> hostname changed to : $1"
echo "rebooting ..."

reboot
