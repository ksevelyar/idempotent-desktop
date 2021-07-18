#!/usr/bin/env bash

artist=$(playerctl -p spotify metadata artist)
title=$(playerctl -p spotify metadata title)

track="$artist $title"
track_path="${track//[^a-z0-9]/-}"

path="$HOME/.cache/lyrics/$track_path.txt"

if [ -f "$path" ]; then
  lyrics=$(cat $path)
else
  lyrics=$(curl -s --get https://makeitpersonal.co/lyrics --data-urlencode artist="$artist" --data-urlencode title="$title")
  mkdir -p $HOME/.cache/lyrics
  printf "$lyrics" > $path
fi

printf "$lyrics" > "$HOME/.cache/lyrics/current-song.txt"

echo "$artist - $title"
