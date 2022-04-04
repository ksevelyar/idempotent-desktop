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

* [CI with flakes and Cachix](/.github/workflows/build.yml)
* Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users)
* All hosts connected with [wireguard](https://github.com/ksevelyar/idempotent-desktop/blob/c77e6ec3f962aa93cae14542f3d4a060feb02441/hosts/skynet.nix#L64-L147)
* `vnc-server` and mosh with [polybar indication for host](/assets/screens/polybar-sshd-vnc-server.png)
* [Terminus](http://terminus-font.sourceforge.net/shots.html) and [NerdFonts](/sys/fonts.nix)
* [Brutal Doom](https://github.com/ksevelyar/brutal-doom), [Quake](https://github.com/ksevelyar/quake), [Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix)
* [battery optimisation](/hardware/power-management.nix) for laptops
* [mpd](/services/mpd.nix), [Spotify](https://open.spotify.com/playlist/1FOoZGP15NMWkGqLDWk3lR?si=a001b656806e46bd) 
* [live-usb](/live-usb/live-usb.nix)
* [sysrq](https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html#what-are-the-command-keys) 
* [tldr](https://github.com/tldr-pages/tldr) aliased to h

## Linux as IDE

* Tiling with leftwm and Polybar or [tmux](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/tmux.nix)
* fish + direnv, alacritty, ripgrep, rsync, fzf, zoxide, delta 
* [Neovim with LSP](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/.config/nvim/init.vim) for Elixir, Rust, Nix and others
* fuzzy search by apps `mod`, emojis `mod + z` and clipboard `mod + c` history wih rofi 
* [copy color of pixel under mouse cursor](/sys/scripts.nix) to clipboard with `mod + k`
* [`PrtScn`](https://github.com/ksevelyar/idempotent-desktop/blob/6adfa52b3404d4f28f1c1b803b40bc5a86c3fde2/users/shared/.config/leftwm/config.toml#L197) to capture region, `mod + PrtScn` to capture fullscreen, record desktop videos with `vokoscreen`
* [Rust boilerplate](https://github.com/rusty-cluster/rust-boilerplate)

## Hardware Engineering

* programmatic cads: libfive, openscad
* slicers for 3d printer: prusa-slicer, cura 
* circuit diagrams: librepcb, fritzing 
* [platformio-cli](https://jeelabs.org/2018/getting-started-bp/)

## Security

* [encrypted root with LUKS2](/doc/encrypted-root.md)
* EdDSA for ssh and gpg keys
* gopass / [browserpass](https://github.com/browserpass/browserpass-extension#available-keyboard-shortcuts) integration
* uBlock Origin
* VPN enabled by default
* [element-desktop](https://matrix.org/)
