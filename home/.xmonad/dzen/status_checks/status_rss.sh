#!/bin/sh

status=$(curl -s -H "Authorization: GoogleLogin auth=$(curl -sd "Email=$gmail_login&Passwd=$gmail_password&service=reader" https://www.google.com/accounts/ClientLogin | grep Auth | sed 's/Auth=\(.*\)/\1/')" "http://www.google.com/reader/api/0/unread-count?all=true?output=json" | awk 'BEGIN {RS="<object>";FS="count\">";sum=0} ; /reading-list/ {print $2}' | cut -d'<' -f1)


if [[ "$status" =~ ^[0-9]+$ ]] && [[ $status -ge 10 ]]
then
  echo $status > /tmp/status_rss
elif [ -f "/tmp/status_rss" ]
then
  rm /tmp/status_rss
fi

