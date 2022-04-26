# [sshd](/services/net/sshd.nix)

* Autostart disabled, use `sudo systemctl start sshd`
* Default port is 9922.

## Specify the port manually on client

```
ssh user@host -p 9922
mosh --ssh="ssh -p 9922" user@host
sshfs -p 9922 skynet:/home/ksevelyar /tmp/sshfs
rsync -ra --info=progress2 -e 'ssh -p 9922' ~/learn tv:learn
```

## Or use a mask:

```
programs.ssh = {
  pubkeyAcceptedKeyTypes = [ "ssh-ed25519" ];
  startAgent = true;
  extraConfig = ''
    Host *.local
      Port 9922
  '';
};
```

```
ssh user@host.local 
mosh user@host.local
sshfs skynet:/home/ksevelyar ~/sshfs
rsync -ra --info=progress2 ~/learn tv.local:learn
```
