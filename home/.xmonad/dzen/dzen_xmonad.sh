#!/bin/bash

export color_main="^fg(#BEB3CD)"
export color_sec1="^fg(#9C71C7)"
export color_sec2="^fg(#6B5A68)"

export font="-xos4-terminus-medium-*-*-*-16-*-*-*-*-*-iso10646-*"
#font="Anonymous Pro 16"

fg_color="#BEB3CD"
bg_color="#0e0e0e"

dzen_style="-fg $fg_color -bg $bg_color -fn $font -h 20"

~/.xmonad/dzen/status_bars/dzen_main.sh      | dzen2 -y 0    -x 1000 -w 1560  -ta r $dzen_style &
~/.xmonad/dzen/status_bars/dzen_audio.sh     | dzen2 -y 0    -x 0    -w 1000 -ta l $dzen_style &
~/.xmonad/dzen/status_bars/dzen_secondary.sh | dzen2 -y 1060 -x 2110 -w 450  -ta r $dzen_style &

