#!/usr/bin/env sh

LOCAL_IP=$(ip route | grep default | awk '{print $9}')
PUBLIC_IP=$(curl ifconfig.me)

notify-send "$LOCAL_IP 🔮 $PUBLIC_IP"
