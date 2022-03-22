# Security

## GPG

### Create template for your keys

`nvim gpg.template`

```conf
Key-Type: eddsa
Key-Curve: Ed25519
Key-Usage: sign
Subkey-Type: ecdh
Subkey-Curve: Curve25519
Subkey-Usage: encrypt
Name-Real: dude
Name-Email: dude@domain.tld
Expire-Date: 0
%commit
```

### Generate a Ed25519 key

```fish
gpg --batch --generate-key gpg.template
```

### Enlist keys

```fish
gpg --list-secret-keys
```

You can use this key for pass now.

## [gopass](https://woile.github.io/gopass-presentation/)

### Init

`gopass init <gpg-id>`

### Generate password with special symbols and copy it to clipboard

`gopass generate -s mail/protonmail.com 80`

### Import your passwords to pass

[pass-import](https://github.com/roddhjav/pass-import#pass-import)

## Opened ports

[firewall-desktop](https://github.com/ksevelyar/idempotent-desktop/blob/mast../services/net/firewall-desktop.nix)

## Show listening ports

`sudo lsof -Pni | grep -i listen`

## [sshd](https://github.com/ksevelyar/idempotent-desktop/blob/0c25763c040e5a50f393d2c2bb7c6eee616f37../services/common.nix#L9-L16)

Autostart disabled, use `sudo systemctl start sshd`

The port is 9922. Use `mosh --ssh="ssh -p 9922" user@host` or `ssh user@host -p 9922` to connect.

In case your sshd is runninng you will see it in polybar with amount of active connects:

![polybar](https://i.imgur.com/zZz3AfZ.png)

The same for x11vnc.

### Check your ssh keys

```bash
bash -c 'for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq'
```

> Today, the RSA is the most widely used public-key algorithm for SSH key. But compared to Ed25519, it’s slower and even considered not safe if it’s generated with the key smaller than 2048-bit length.

[upgrade-your-ssh-key-to-ed25519](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)

`ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519`

## Fail2Ban

Currently integrated with `sshd`.

## hardened kernel

You can switch to the hardened kernel with one line: [sysctl.nix](https://github.com/ksevelyar/idempotent-desktop/blob/504570d52ab79463704e4ddcf908f82c593621../sys/sysctl.nix#L4-L6)

## Monitor

- [email](https://haveibeenpwned.com/)
