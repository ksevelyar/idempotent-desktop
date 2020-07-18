#!/usr/bin/env bash
pkill -9 conky

conky -c ~/.config/conky/conky-taskwarrior.conf -d
conky -c ~/.config/conky/conky-lyrics.conf -d
