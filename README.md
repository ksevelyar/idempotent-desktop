# λ Idempotent Freelancer Desktop 
*(work in progress)*

* NixOS, Xmonad, Polybar, Alacritty, Rofi, Conky, Picom
* Neovim (LSP via coc.nvim): Elixir, JS, HTML, CSS
* https://github.com/ksevelyar/joker.vim (heavily inspired by vim-gotham)
* FZF, Ripgrep, Fish, Tmux, Zeal
* SpaceFM, nnn, nomacs
* Firefox with Vimium
* arduino, fritzing
* Cura, OpenSCAD, Gimp
* Adblocking DNS with `dnsmasq` by pi-hole methodology
* Native virtualization with kvm & virt-manager
* Tor, Switchy Omega, qTox 
* Easily hackable live usb (with and without X)
* Bypassing symmetrical NATs with WireGuard
* Pair programming with x11vnc & sshd
* steam, lutris, playonlinux
* nmtui + blueman-manger 
* ssd friendly with fstrim service and `noatime` mount option
* Proprietary suite: Upwork, Slack, Skype, Google-Chrome, Google-Play-Music-Desktop-Player, Telegram, Memtest, Broadcom Wi-fi drivers

## rofi, sshd, x11vnc

![screen](https://i.imgur.com/TWyVk5C.png)

## conky + gpmdp + taskwarrior

![screen](https://i.imgur.com/fWKORz4.png)

## neovim + tmux (via xmonad scratchpad)

![screen](https://i.imgur.com/z95oCew.png)

## spacefm

![screen](https://i.imgur.com/h2nnCWM.png)

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

```
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync
```

## install

```
sudo nixos-generate-config --root /tmp
sudo cp -ra /etx/nixos{,.bak}
sudo git clone git@github.com:ksevelyar/dotfiles.git /etc/nixos

sudo nix-channel --add https://nixos.org/channels/nixos-19.09 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo ln -s /etc/nixos/hosts/hk47.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch --keep-going

sudo mkdir -p /storage/screenshots
```
