#!/usr/bin/env fish
printf (string split 'config-' (pgrep -a openvpn))[2]
