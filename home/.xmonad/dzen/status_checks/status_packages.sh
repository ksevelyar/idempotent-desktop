#!/bin/sh

sudo yaourt -Sy --devel --aur > /dev/null 2>&1

status=$(yaourt -Qu | wc -l)

if [[ "$status" =~ ^[0-9]+$ ]] && [ $status -ge 50 ]
then
  echo $status > /tmp/status_packages
elif [ -f "/tmp/status_packages" ]
then
  rm /tmp/status_packages
fi
