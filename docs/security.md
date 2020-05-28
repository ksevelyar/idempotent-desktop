# Sec

You can run tails or kali in virt-manager ¯\_(ツ)_/¯

## [Opened ports](https://github.com/ksevelyar/dotfiles/blob/master/modules/net/firewall-desktop.nix)

## DNS over TLS with kresd

[services.kresd](https://github.com/ksevelyar/dotfiles/blob/42b8264d1b259c99f887be38224f3ae0a62448c5/modules/net/firewall-desktop.nix#L4-L14)

## Check your ssh keys

```bash
bash -c 'for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq'
```

> Today, the RSA is the most widely used public-key algorithm for SSH key. But compared to Ed25519, it’s slower and even considered not safe if it’s generated with the key smaller than 2048-bit length.

[upgrade-your-ssh-key-to-ed25519](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)

`ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519`
