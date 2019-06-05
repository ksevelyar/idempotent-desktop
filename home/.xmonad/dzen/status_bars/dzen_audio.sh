#!/bin/bash

#=== Settings ===#
SLEEP=0.5

speaker_icon="^i($HOME/.xmonad/dzen/icons/spkr_01.xbm)"
mpd_icon="^i($HOME/.xmonad/dzen/icons/mpd.xbm)"


#=== Loop ===#
while :; do

# volume
playback=$(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p')

if [ $playback == "0%" ]
then
playback_format="000%"
elif [ $playback == "100%" ]
then
playback_format="${color_main}100%"
else
playback_format=$(printf "%04s" $playback | sed "s/ /0/g;s/\(^0\+\)/\1${color_main}/")
fi

volume="${color_sec1}${speaker_icon} ${color_sec2}${playback_format}"

# mpd
if [ $(gpmdp-remote status) == "Playing" ]
then
  gpmdp="${color_sec1}${mpd_icon} ${color_main}$(gpmdp-remote current)"
else
  gpmdp=""
fi

echo " $volume  $gpmdp"
sleep $SLEEP; done
