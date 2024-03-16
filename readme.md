# Idempotent Desktop [![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)](https://github.com/ksevelyar/idempotent-desktop/actions)

This repo is just a bunch of NixOS modules, so you can pick or override anything.

![leftwm](/assets/screens/leftwm.png)

## Features
* [CI with flakes and Cachix](/.github/workflows/build.yml)
* Multiple [hosts](https://github.com/ksevelyar/idempotent-desktop/tree/main/hosts), each host can contain multiple [users](https://github.com/ksevelyar/idempotent-desktop/tree/main/users)
* All hosts connected with [wireguard](https://github.com/ksevelyar/idempotent-desktop/blob/198d0192d958e871d184f85338c35440ae033c25/hosts/skynet.nix#L57-L135)
* `vnc-server` and mosh with [polybar indication for host](/assets/screens/polybar-sshd-vnc-server.png)
* [Terminus](http://terminus-font.sourceforge.net/shots.html) and [NerdFonts](/sys/fonts.nix)
* [Brutal Doom](https://github.com/ksevelyar/brutal-doom), [Quake](https://github.com/ksevelyar/quake), [Steam](https://github.com/ksevelyar/idempotent-desktop/blob/main/packages/games.nix)
* [battery optimisation](/hardware/power-management.nix) for laptops
* [picard][picard], [mpd](/services/mpd.nix), [ncmpcpp][ncmpcpp], [mpdscribble](https://listenbrainz.org/user/ksevelyar/)  
* [mpv](/users/shared/mpv), [imv][imv]
* [live-usb](/live-usb/live-usb.nix)
* [tealdeer](https://github.com/dbrgn/tealdeer) aliased to h

## Linux as IDE
* Tiling with [leftwm](/users/shared/leftwm/config.toml), polybar, dunst and [tmux](/packages/tmux.nix)
* [fish](/doc/fish.md), direnv, alacritty, ripgrep, rsync, fzf, [zoxide][zoxide], [delta][delta], gitg, bat, exa 
* [Neovim with LSP](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/nvim/init.vim) for Elixir, Rust, Nix, Lua and others
* fuzzy search by apps [`mod`](/doc/run-rofi-with-one-key.md), emojis `mod + z` and clipboard history `mod + c` wih [rofi](https://github.com/ksevelyar/idempotent-desktop/blob/main/users/shared/rofi/grey.rasi)
* [copy color of pixel under mouse cursor](/services/x.nix#L5-L14) to clipboard with `mod + k`
* [`PrtScn`](https://github.com/ksevelyar/idempotent-desktop/blob/ea28dfc28596d8edb3b88683e9960b4a32cc9c46/users/shared/leftwm/config.toml#L180-L184) to capture region, `mod + PrtScn` to capture fullscreen, record desktop videos with `vokoscreen`

## Security
* [encrypted root with LUKS2](/doc/encrypted-root.md)
* [EdDSA for ssh and gpg keys](/doc/keys.md)
* gopass / [browserpass](https://github.com/browserpass/browserpass-extension#available-keyboard-shortcuts) integration
* [uBlock](https://github.com/gorhill/uBlock)
* [VPN](https://github.com/ksevelyar/idempotent-desktop/blob/main/services/vpn.nix)

[picard]: https://picard.musicbrainz.org/quick-start/
[imv]: /users/shared/imv/config
[ncmpcpp]: /assets/screens/ncmpcpp.png
[delta]: https://github.com/dandavison/delta
[zoxide]: https://github.com/ajeetdsouza/zoxide
