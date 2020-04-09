#!/bin/bash

# Note: Unmounting of iso files is performed by the fuseiso or udevil device
# handler, not this file handler.

# Use fuseiso or udevil ?
fuse="$(which fuseiso)"  # remove this line to use udevil only
if [[ -z "$fuse" ]]; then
    udevil="$(which udevil)"
    if [[ -z "$udevil" ]]; then
        echo "You must install fuseiso or udevil to mount ISOs with this handler."
        exit 1
    fi
    # use udevil - attempt mount
    uout="$($udevil mount "$fm_file" 2>&1)"
    err=$?; echo "$uout"
    if [ $err -eq 2 ]; then
        # is file already mounted? (english only)
        point="${uout#* is already mounted at }"
        if [ "$point" != "$uout" ]; then
            point="${point% (*}"
            if [ -x "$point" ]; then
                spacefm -t "$point"
                exit 0
            fi
        fi
    fi
    [[ $err -ne 0 ]] && exit 1
    point="${uout#Mounted }"
    [[ "$point" = "$uout" ]] && exit 0
    point="${point##* at }"
    [[ -d "$point" ]] && spacefm "$point" &
    exit 0
fi
# use fuseiso - is file already mounted?
canon="$(readlink -f "$fm_file" 2>/dev/null)"
if [ -n "$canon" ]; then
    canon_enc="${canon// /\\040}" # encode spaces for mtab+grep
    if grep -q "^$canon_enc " ~/.mtab.fuseiso 2>/dev/null; then
        # file is mounted - get mount point
        point="$(grep -m 1 "^$canon_enc " ~/.mtab.fuseiso \
                 | sed 's/.* \(.*\) fuseiso .*/\1/' )"
    if [ -x "$point" ]; then
            spacefm "$point" &
            exit
        fi
    fi
fi
# mount & open
fuseiso %f %a && spacefm %a &
