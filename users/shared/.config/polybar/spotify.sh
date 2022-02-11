#!/usr/bin/env bash

artist=$(playerctl -p spotify metadata artist)
title=$(playerctl -p spotify metadata title)

echo "$artist - $title"
