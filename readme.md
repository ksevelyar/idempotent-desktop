# Idempotent Desktop [![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions)

This repo is just a bunch of NixOS modules, so you can pick or override anything. 

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)
![tomb](https://i.imgur.com/XwVKUrm.png)

## Install

```
sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /etc/nixos
sudo chown -R 1000:users /etc/nixos

cd /etc/nixos
mv configuration.nix{,.bak}
ln -s hosts/hk47.nix configuration.nix

sudo nixos-rebuild switch
```

## Features

1. Flakes for reproducible builds
2. Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users).
4. Tiling with Xmonad and Polybar
6. [Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix), Spotify, Netflix

## Linux as IDE

* fish, alacritty, ripgrep, fd, fzf, zoxide, tldr, delta 
* Neovim with LSP for js, elixir, lua, rust and others.

## Security

* tomb / LUKS
* gopass / browserpass integration
* uBlock Origin
* VPN enabled by default
* Tor
