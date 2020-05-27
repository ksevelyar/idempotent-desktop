# λ Idempotent Freelancer Desktop

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)

🍕 This repo is just a bunch of NixOS [modules](https://github.com/ksevelyar/dotfiles/tree/master/modules), so you can pick or override anything
🍕 You can create [live usb](https://nixos.org/nixos/manual/index.html#sec-building-cd) with single one-liner
🍕 You can use these dotfiles in other unix too, check [home](https://github.com/ksevelyar/dotfiles/tree/master/home)

## Docs

_work in progress_

[netlify](https://idempotent-desktop.netlify.app/)

Feel free to create an issue if something is unclear or broken.

## Sys

- NixOS, Xmonad, Polybar, Alacritty, Tmux
- jgmenu, rofi-pass, rofi-emoji, rofi-calc
- mpv, nomacs, imv, feh
- Terminus.otb, Nerd Fonts
- fish, z.lua, SpaceFM, nnn, ncdu
- nmtui, blueman-manger
- ssd friendly with fstrim service and `noatime` mount option
- pair programming with x11vnc & sshd
- native virtualization with kvm & virt-manager
- easily hackable live usb

## Linux as IDE

- [joker.vim](https://github.com/ksevelyar/joker.vim) (heavily inspired by vim-gotham)
- LSP via coc.nvim for Elixir, JS, HTML, CSS
- FZF, Ripgrep, Fish, Tmux, Zeal
- Firefox with [tridactyl](https://tridactyl.xyz/)
- arduino, fritzing
- Cura, OpenSCAD

## Live Usb

[live-usb.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb.nix) ~2GB

[live-usb-minimal.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb-minimal.nix) ~900MB
