#!/usr/bin/env sh
printf "%s\n" \
  '{"namespace": "connect","method": "connect","arguments": ["cli", "621b2119-3de8-4d66-827c-588bd0c603fd"]}' \
  '{"namespace": "playback","method": "playPause"}' | websocat ws://127.0.0.1:5672
