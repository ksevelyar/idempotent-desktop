#!/usr/bin/env sh
DATA=$(cat ~/.config/Google\ Play\ Music\ Desktop\ Player/json_store/playback.json)

PLAYING=$(echo $DATA | jq -r '.playing')

if [ $PLAYING == 'false' ]; then
  echo ""
else
  ARTIST=$(echo $DATA | jq -r '.song.artist')
  TITLE=$(echo $DATA | jq -r '.song.title')

  echo "$ARTIST - $TITLE"
fi
