# λ Idempotent Freelancer Desktop

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)

🍕 *work in progress* 🍕

**Sys**
* NixOS, Xmonad, Polybar, Alacritty, Rofi, Conky, Picom
* mpv, imv, feh
* Pixel perfect font with Terminus.otb
* fish, z.lua, SpaceFM, nnn, ncdu
* nmtui + blueman-manger
* ssd friendly with fstrim service and `noatime` mount option
* Pair programming with x11vnc & sshd
* Native virtualization with kvm & virt-manager
* [Easily hackable live usb](https://github.com/ksevelyar/dotfiles#live-usb)

**IDE**
* LSP via coc.nvim for Elixir, JS, HTML, CSS
* FZF, Ripgrep, Fish, Tmux, Zeal
* Firefox with Vimium
* [joker.vim](https://github.com/ksevelyar/joker.vim) (heavily inspired by vim-gotham)
* arduino, fritzing
* Cura, OpenSCAD, Gimp

**Sec**
* browserpass, gopass, rofi-pass
* Adblocking DNS with `dnsmasq` by pi-hole methodology
* Tor, Switchy Omega, qTox
* Bypassing symmetrical NATs with WireGuard

**Polybar scripts**
* weather via wttr.in
* local and public ips
* vpn & ssh indicator
* google-play-music-desktop-player current song
* bandwidth

**Games**
* steam, playonlinux, wine

**Proprietary suite**
* Upwork, Slack, Skype, Telegram Desktop
* Google-Chrome, Google-Play-Music-Desktop-Player
* Memtest, Broadcom Wi-Fi drivers

## [alacritty scratchpad](https://github.com/ksevelyar/dotfiles/blob/93dad4b540532e4feee2eb5c2a372d7273ac6102/home/.xmonad/xmonad.hs#L226-L228) 

![blank](https://i.imgur.com/J5dE18O.png)

## [rofi](https://github.com/ksevelyar/dotfiles/tree/master/home/.config/rofi) with plugins and argb transparency

![rofi](https://i.imgur.com/oGVe1s2.png)

## spacefm + ncdu

![screen](https://i.imgur.com/amqrjk7.png)

## google-chrome, gotop, gpmdp

![screen](https://i.imgur.com/wiIFOdI.png)

## firefox

![screen](https://i.imgur.com/BYpqCbi.png)

## steam

![screen](https://i.imgur.com/GxNoW6l.png)

## doom 2

![screen](https://i.imgur.com/xXcIXu0.png)

## cava + gpmdp

![screen](https://i.imgur.com/Yvq668e.png)

## kvm + virt-manager + live usb

![screen](https://i.imgur.com/1n0SWwG.png)

## live usb

[live-usb.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb.nix) ~2GB

[live-usb-minimal.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb-minimal.nix) ~900MB

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync
```

## install

```sh
sudo nixos-generate-config --root /tmp
sudo cp -ra /etx/nixos{,.bak}
sudo git clone git@github.com:ksevelyar/dotfiles.git /etc/nixos

sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

sudo nix-channel --update
# retry unless success
# while true; sudo nix-channel --update && break; end

sudo ln -s /etc/nixos/hosts/hk47.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch --keep-going
```
