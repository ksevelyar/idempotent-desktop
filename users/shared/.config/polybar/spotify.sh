#!/usr/bin/env bash

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)

path="$HOME/.cache/lyrics/$artist-$title.txt"
path="${path// /-}"

if [ -f "$path" ]; then
  lyrics=$(cat $path)
else
  lyrics=$(curl -s --get https://makeitpersonal.co/lyrics --data-urlencode artist="$artist" --data-urlencode title="$title")
  mkdir -p $HOME/.cache/lyrics
  printf "$lyrics" > $path
fi

printf "$lyrics" > /tmp/.current_song.txt

echo "$artist - $title"
