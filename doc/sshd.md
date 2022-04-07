# [sshd](/services/net/sshd.nix)

Autostart disabled, use `sudo systemctl start sshd`

## ssh

`ssh user@host -p 9922`

## mosh

`mosh --ssh="ssh -p 9922" user@host`

## sshfs

`sshfs -p 9922 skynet:/home/ksevelyar /tmp/sshfs`

## rsync

`rsync -ra --info=progress2 -e 'ssh -p 9922' ~/learn tv.local:learn`
