#!/run/current-system/sw/bin/env bash
set -e

if [ ! -d ~/.mail ]; then
    notify-send "~/.mail does not mounted"
    exit
fi

mbsync -a
notmuch new
