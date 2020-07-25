#!/bin/sh

WEATHER=$(curl --globoff -s "wttr.in/Moscow?format=[%C]+%t")

if [[ "$WEATHER" == *"°C"* ]]; then
  echo $WEATHER | sed -e 's/\[/%{F#6B5A68}/' | sed -e 's/\]/%{F-}/' | sed -e 's/Clear//'
else
  echo "%{F#6B5A68}[Zzz]%{F-} wttr.in"
fi
