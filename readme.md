# Idempotent Desktop [![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions)

This repo is just a bunch of NixOS modules, so you can pick or override anything. 

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)

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
4. Tiling with leftwm and Polybar or [tmux](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/tmux.nix)
6. [Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix), [Spotify](https://open.spotify.com/playlist/1FOoZGP15NMWkGqLDWk3lR?si=a001b656806e46bd), Netflix

## Linux as IDE

* fish + direnv, mosh, alacritty, ripgrep, rsync, fzf, zoxide, tldr, delta 
* [Neovim with LSP](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/.config/nvim/init.vim) for Elixir, Rust, Nix and others.

## Security

* all hosts connected with [wireguard](https://github.com/ksevelyar/idempotent-desktop/blob/main/hosts/skynet.nix#L67)
* tomb / LUKS
* gopass / [browserpass](https://github.com/browserpass/browserpass-extension#available-keyboard-shortcuts) integration
* uBlock Origin
* VPN enabled by default
* element-desktop
