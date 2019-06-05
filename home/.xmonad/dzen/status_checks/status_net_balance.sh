#!/bin/bash

curl -s -k --cookie-jar /tmp/onlime.cookies --data \
"login_credentials[login]=${onlime_login}&login_credentials[password]=${onlime_password}" \
https://my.onlime.ru/session/login

status=$(curl -s -k --cookie /tmp/onlime.cookies https://my.onlime.ru/json/cabinet \
| grep -o "lock\":[0-9.]*" | sed s/[^0-9.]//g)

rm /tmp/onlime.cookies

if [[ "$status" =~ ^[0-9]+$ ]] && [ $status -le 7 ]; then
  echo $status > /tmp/status_net_balance
elif [ -f "/tmp/status_net_balance" ]; then
  rm /tmp/status_net_balance
fi


