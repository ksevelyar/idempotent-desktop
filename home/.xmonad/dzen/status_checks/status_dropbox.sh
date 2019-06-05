#!/bin/bash

file='/tmp/status_dropbox'
status=$(dropbox status)

if [[ ("$status" == "Idle" || "$status" == "Dropbox isn't running!") && -f $file ]]; then
  rm $file
  exit

elif [[ $status = "Idle" || $status == "Dropbox isn't running!" ]]; then
  exit

elif [[ $status =~ (Downloading|Uploading).*left.* ]]; then
  left=$(echo $status | awk '{print $6 substr($7,1,1)}')
  echo $left > $file

fi
