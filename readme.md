# Idempotent Desktop [![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions)

This repo is just a bunch of NixOS modules, so you can pick or override anything. 

![leftwm](/assets/screens/leftwm.png)

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

* Flakes for reproducible builds
* Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users)
* [Terminus](http://terminus-font.sourceforge.net/shots.html) and [NerdFonts](/sys/fonts.nix)
* [Brutal Doom](https://github.com/ksevelyar/brutal-doom), [Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix)
* [battery optimisation](/hardware/power-management.nix) for laptops
* [mpd](/services/mpd.nix), [Spotify](https://open.spotify.com/playlist/1FOoZGP15NMWkGqLDWk3lR?si=a001b656806e46bd) 
* [live-usb](/live-usb/live-usb.nix)
* [sysrq](https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html#what-are-the-command-keys) 
* [tldr](https://github.com/tldr-pages/tldr) aliased to h

## Linux as IDE

* Tiling with leftwm and Polybar or [tmux](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/tmux.nix)
* fish + direnv, mosh, alacritty, ripgrep, rsync, fzf, zoxide, delta 
* [Neovim with LSP](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/.config/nvim/init.vim) for Elixir, Rust, Nix and others
* fuzzy search by apps, emojis and clipboard history wih rofi 
* [copy color of pixel under mouse cursor](/sys/scripts.nix) to clipboard with `mod + k`

## Hardware Engineering

* programmatic cads: libfive, openscad
* slicers for 3d printer: prusa-slicer, cura 
* circuit diagrams: librepcb, fritzing 
* [platformio-cli](https://jeelabs.org/2018/getting-started-bp/)

## Security

* [encrypted root with LUKS2](/doc/encrypted-root.md)
* all hosts connected with [wireguard](https://github.com/ksevelyar/idempotent-desktop/blob/main/hosts/skynet.nix#L67)
* EdDSA for ssh and gpg keys
* gopass / [browserpass](https://github.com/browserpass/browserpass-extension#available-keyboard-shortcuts) integration
* uBlock Origin
* VPN enabled by default
* [element-desktop](https://matrix.org/)
