#!/usr/bin/env bash
pkill -9 conky

conky -c ~/.config/conky/conky-taskwarrior.conf --pause=2 -d
conky -c ~/.config/conky/conky-lyrics.conf --pause=2 -d
