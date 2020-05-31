#!/usr/bin/env sh

# https://unix.stackexchange.com/a/181920

SP_VERSION="0.1"
SP_DEST="org.mpris.MediaPlayer2.spotify"
SP_PATH="/org/mpris/MediaPlayer2"
SP_MEMB="org.mpris.MediaPlayer2.Player"

SPOTIFY_METADATA="$(dbus-send                                                 \
 --print-reply                                  `# We need the reply.`        \
 --dest=$SP_DEST                                                              \
 $SP_PATH                                                                     \
 org.freedesktop.DBus.Properties.Get                                          \
 string:"$SP_MEMB" string:'Metadata'                                          \
 | grep -Ev "^method"                           `# Ignore the first line.`    \
 | grep -Eo '("(.*)")|(\b[0-9][a-zA-Z0-9.]*\b)' `# Filter interesting fiels.` \
 | sed -E '2~2 a|'                              `# Mark odd fields.`         \
 | tr -d '\n'                                   `# Remove all newlines.`     \
 | sed -E 's/\|/\n/g'                           `# Restore newlines.`        \
 | sed -E 's/(xesam:)|(mpris:)//'               `# Remove ns prefixes.`      \
 | sed -E 's/^"//'                              `# Strip leading...`         \
 | sed -E 's/"$//'                              `# ...and trailing quotes.`  \
 | sed -E 's/\"+/|/'                             `# Regard "" as seperator.`  \
 | sed -E 's/ +/ /g'                            `# Merge consecutive spaces.`\
)"

ARTIST=$(echo "$SPOTIFY_METADATA" | sed -n 's/artist|//p')
TITLE=$(echo "$SPOTIFY_METADATA" | sed -n 's/title|//p')

echo "$ARTIST - $TITLE"
