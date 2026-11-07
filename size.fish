#!/usr/bin/env fish

set -l sys (readlink -f /run/current-system)

set -l nar_total (nix path-info -rSh $sys | tail -n 1 | awk '{print $2,$3}')

echo "$nar_total"
