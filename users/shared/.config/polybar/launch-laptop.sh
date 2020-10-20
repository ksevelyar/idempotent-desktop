#!/usr/bin/env bash

# Terminate already running bar instances
pkill -9 polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar laptop-top >>/tmp/polybar1.log 2>&1 &
polybar laptop-bottom >>/tmp/polybar2.log 2>&1 &

echo "Laptop bars launched..."
