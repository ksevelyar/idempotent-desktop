# Idempotent Desktop [![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions)

This repo is just a bunch of NixOS modules, so you can pick or override anything. 

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)
![tomb](https://i.imgur.com/XwVKUrm.png)

## Features

1. Flakes for reproducible builds
2. Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users).
4. Tiling with Xmonad and Polybar
6. [Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix)

### Linux as IDE

* fish, alacritty, ripgrep, fd, fzf, zoxide, tldr, delta 
* Neovim with LSP for js/elixir/rust

### Security

* tomb / LUKS
* gopass / browserpass integration
* VPN enabled by default
* Tor
