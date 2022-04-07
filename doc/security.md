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

You can use this key for pass.

### Enlist keys

```fish
gpg --list-secret-keys
```

### Export key

```
gpg --export-secret-keys YOUR_ID_HERE > private.key
```

### Import key

```
gpg --import private.key
```

## [gopass](https://woile.github.io/gopass-presentation/)

### Init

`gopass init <gpg-id>`

### Generate password with special symbols and copy it to clipboard

`gopass generate -s mail/protonmail.com 80`

## Opened ports

[firewall-desktop](/services/net/firewall-desktop.nix)

## Show listening ports

`sudo lsof -Pni | grep -i listen`

## [sshd](/services/net/sshd.nix)

Autostart disabled, use `sudo systemctl start sshd`

The port is 9922. Use `mosh --ssh="ssh -p 9922" user@host` or `ssh user@host -p 9922` to connect.

### Check your ssh keys

```bash
bash -c 'for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq'
```

> Today, the RSA is the most widely used public-key algorithm for SSH key. But compared to Ed25519, it’s slower and even considered not safe if it’s generated with the key smaller than 2048-bit length.

[upgrade-your-ssh-key-to-ed25519](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)

`ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519`

