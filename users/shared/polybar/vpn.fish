#!/usr/bin/env fish
set VPN (printf (string split 'config-' (pgrep -a openvpn))[2])

if set -q VPN
    echo $VPN
else
    echo ""
end
