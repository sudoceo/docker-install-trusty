#!/bin/bash

if [ ! $# == 1 ]; then
  echo "Only one argument (new host name) allowed ..."
  exit
fi

echo ">>>>>> changing hostname ... "

hostnamectl set-hostname "$1"
service     hostname restart
service     networking restart

echo ">>>>>> hostname changed to : $1"
