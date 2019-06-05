#!/bin/bash

source ~/private/passwords.sh

# ----------------
# Initial check
# ----------------
(
/home/ksevelyar/.asdf/shims/ruby ~/.xmonad/dzen/status_checks/status_weather.rb
# ~/.xmonad/dzen/status_checks/status_net_balance.sh
# ~/.xmonad/dzen/status_checks/status_mail.sh
# ~/.xmonad/dzen/status_checks/status_rss.sh
# ~/.xmonad/dzen/status_checks/status_packages.sh
) &

(while :; do

/home/ksevelyar/.asdf/shims/ruby ~/.xmonad/dzen/status_checks/status_weather.rb

sleep 1m; done ) &

#===
# (while :; do
#
# # ~/.xmonad/dzen/status_checks/status_mail.sh &
# # ~/.xmonad/dzen/status_checks/status_rss.sh &
# # ~/.xmonad/dzen/status_checks/status_packages.sh &
#
# sleep 30s; done ) &
#
# ===
# (while :; do
#
# ~/.xmonad/dzen/status_checks/status_dropbox.sh &
#
# sleep 1s; done ) &
