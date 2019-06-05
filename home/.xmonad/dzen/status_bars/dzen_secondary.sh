#!/bin/bash

#=== Variables ===#
icon_path="$HOME/.xmonad/dzen/icons"

dropbox_icon="dropbox.xbm"
net_balance_icon="wired.xbm"
packages_icon="pacman.xbm"
rss_icon="dish.xbm"
mail_icon="mail.xbm"
weather_icon="temp.xbm"

date_icon="^i($icon_path/date.xbm)"
clock_icon="^i($icon_path/clock.xbm)"

#=== Functions ===#

function ifexist {
  for i in /tmp/status_${1}*; do
    if [ -f "$i" ]; then
      temp="${1}_icon"
      icon="^i($icon_path/${!temp})"
      echo "${color_sec1}${icon} ${color_main}$(cat /tmp/status_${1}*)  "
    fi
  done
}

#=== Loop ===#
while :; do

dropbox="$(ifexist dropbox)"
net_balance="$(ifexist net_balance)"
packages="$(ifexist packages)"
rss="$(ifexist rss)"
mail="$(ifexist mail)"
weather="$(ifexist weather)"

#date
date="${color_sec1}${date_icon} ${color_main}$(date +'%A %B %d')"

#clock
clock="${color_sec1}${clock_icon} ${color_main}$(date +%H:%M)"


echo "$dropbox$net_balance$packages$mail$rss$weather$date  $clock "

sleep 1; done
