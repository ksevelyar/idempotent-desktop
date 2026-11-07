# Secrets
## Declarative secrets with agenix
Agenix encrypts each secret for its authorized recipients. NixOS decrypts it on systems with a matching identity key.

### Create an SSH key
Generate an Ed25519 SSH key for each user or system that needs access to a secret:
`ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519`

Ed25519 is a modern, compact choice for SSH. If you use RSA, choose a key of at least 2048 bits. See [Upgrade your SSH key to Ed25519](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54).

### Declare a secret
Add the secret and its authorized recipients to `secrets.nix`:
```nix
"secrets/ksevelyar/xray.age".publicKeys = [ ksevelyar hk47 ];
```

### Encrypt or edit a secret
Run `agenix -e` with the secret's path:
`agenix -e secrets/ksevelyar/xray.age`

### Use a secret in NixOS
Refer to the encrypted file from your configuration and use the runtime path provided by agenix:
```nix
age.secrets.ksevelyar-xray-json.file = ../secrets/ksevelyar/xray.age;

services.xray = {
  enable = true;
  settingsFile = config.age.secrets.ksevelyar-xray-json.path;
};

age.identityPaths = [ "/home/ksevelyar/.ssh/id_ed25519" ];
```

### Verify SSH keys
List the fingerprints of your SSH keys:
```bash
for key in ~/.ssh/id_*; do
  ssh-keygen -l -f "$key"
done | uniq
```

## On-demand secrets with gopass
Gopass stores passwords as encrypted entries and uses GPG keys to protect them.

### Create a GPG key
Create a key-generation template in `gpg.template`:
```conf
Key-Type: eddsa
Key-Curve: Ed25519
Key-Usage: sign
Subkey-Type: ecdh
Subkey-Curve: Curve25519
Subkey-Usage: encrypt
Name-Real: Your Name
Name-Email: you@example.com
Expire-Date: 0
%commit
```

Generate the key:
`gpg --batch --generate-key gpg.template`

### List, export, and import keys
List your secret keys:
`gpg --list-secret-keys`

Export a secret key and keep the resulting file secure:
`gpg --export-secret-keys <gpg-id> > private.key`

Import a secret key:
`gpg --import private.key`

### Initialize gopass
Initialize the store with your GPG key ID:
`gopass init <gpg-id>`

### Generate a password
Generate an 80-character password with symbols and copy it to the clipboard:
`gopass generate -s mail/protonmail.com 80`
