# Idempotent Desktop [![build](https://github.com/ksevelyar/idempotent-desktop/actions/workflows/build.yml/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions/workflows/build.yml)

## Overview
* Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users)
* Cachix: build custom packages once and share between all nodes
* All hosts connected with [wireguard](https://github.com/ksevelyar/idempotent-server/blob/main/services/net/wireguard.nix) and rustdesk
* [Persistent USB](/usb/persistent.nix) for quick setup and maintenance of workstations

## Linux as IDE
* Tiling with hyprland
* [fish](/doc/fish.md), direnv, alacritty, ripgrep, fd, fzf, [zoxide][zoxide], [delta][delta]
* [Neovim with LSP and TS](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/nvim/init.lua)
* Pixel color picker
* Screenshot & screen recording

## Security
* declarative secrets with [agenix](/doc/agenix.md)
* [encrypted root with LUKS2](/doc/encrypted-root.md)
* [EdDSA for ssh and gpg keys](/doc/keys.md)
* gopass / [browserpass](https://github.com/browserpass/browserpass-extension#available-keyboard-shortcuts) integration
* [uBlock](https://github.com/gorhill/uBlock)

## Inference
* [ollama & comfy](https://github.com/ksevelyar/playground-inference)
* declarative agent: WIP

## Chill
* [Heroic and Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix)
* mpv, [imv][imv], spotify

[imv]: /users/shared/imv/config
[delta]: https://github.com/dandavison/delta
[zoxide]: https://github.com/ajeetdsouza/zoxide
