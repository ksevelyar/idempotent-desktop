#!/usr/bin/env sh
DATA=$(cat ~/.config/Google\ Play\ Music\ Desktop\ Player/json_store/playback.json)

ARTIST=$(echo $DATA | jq -r '.song.artist')
TITLE=$(echo $DATA | jq -r '.song.title')

if [ "$TITLE" == "null" ]; then
  echo ""
else
  echo "%{A1:sh /etc/nixos/home/.config/polybar/gpmdp-next.sh:}$ARTIST - $TITLE%{A}"
fi
