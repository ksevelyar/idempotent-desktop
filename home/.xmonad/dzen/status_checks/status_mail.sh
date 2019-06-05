#!/bin/sh

status=$(curl -u ${gmail_login}:${gmail_password} \
-s "https://mail.google.com/mail/feed/atom"\
| grep -Eo "<fullcount>([0-9]+)" | sed "s/[^0-9.]//g")

if [[ "$status" -gt 0 ]]; then
  echo $status > /tmp/status_mail
elif [[ -f "/tmp/status_mail" ]]; then
  rm /tmp/status_mail
fi
