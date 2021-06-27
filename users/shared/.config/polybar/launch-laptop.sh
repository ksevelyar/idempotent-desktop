#!/usr/bin/env bash

# Terminate already running bar instances
pkill -9 polybar

# wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a ~/.cache/polybar-top.log ~/.cache/polybar-bottom.log
polybar laptop-top >>~/.cache/polybar-top.log 2>&1 &
polybar laptop-bottom >>~/.cache/polybar-bottom.log 2>&1 &
echo "Polybar launched."
