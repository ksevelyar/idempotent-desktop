# Idempotent Desktop [![build](https://github.com/ksevelyar/idempotent-desktop/actions/workflows/build.yml/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions/workflows/build.yml)

![hyprland](/assets/screens/hyprland.png)
![hyprland](/assets/screens/neovim.png)

## Overview
* Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users)
* Build custom packages once and share them between all nodes with cachix
* All hosts connected with [wireguard](https://github.com/ksevelyar/idempotent-server/blob/main/services/net/wireguard.nix) and rustdesk
* [Persistent USB](/usb/persistent.nix) for quick setup and maintenance of workstations

## Linux as IDE
* [Neovim with LSP and TS](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/nvim/init.lua) that auto-loads nix flakes with direnv
* Tiling with [hyprland](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/ksevelyar/hk47/hypr/hyprland.conf)
* [fish](/doc/fish.md), direnv, alacritty, ripgrep, fd, fzf, [zoxide][zoxide], [delta][delta]
* Pixel color picker
* Screenshot and screen recording

## Security
* Declarative secrets with [agenix](/doc/agenix.md)
* [Encrypted root with LUKS2](/doc/encrypted-root.md)
* [EdDSA for SSH and GPG keys](/doc/keys.md)
* gopass / [browserpass](https://github.com/browserpass/browserpass-extension#available-keyboard-shortcuts) integration
* [uBlock](https://github.com/gorhill/uBlock)

## Chill
* [Heroic and Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix)
* [retroarch](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games-retro.nix) for nes, snes, genesis
* mpv, swayimg, spotify

[delta]: https://github.com/dandavison/delta
[zoxide]: https://github.com/ajeetdsouza/zoxide
