#!/usr/bin/env sh
COMMANDS='
{"namespace": "connect","method": "connect","arguments": ["cli", "621b2119-3de8-4d66-827c-588bd0c603fd"]}
{"namespace": "playback","method": "forward"}
'

printf "%s\n" '{"namespace": "connect","method": "connect","arguments": ["cli", "621b2119-3de8-4d66-827c-588bd0c603fd"]}' '{"namespace": "playback","method": "rewind"}' | websocat ws://127.0.0.1:5672
