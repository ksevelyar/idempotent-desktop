#!/usr/bin/env bash
pkill -9 conky

conky -c ~/.config/conky/conky-taskwarrior.conf --daemonize --pause=3
conky -c ~/.config/conky/conky-lyrics.conf --daemonize --pause=3 
