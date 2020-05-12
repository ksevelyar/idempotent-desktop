# λ Idempotent Freelancer Desktop 

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)

🍕 *work in progress* 🍕

* NixOS, Xmonad, Polybar, Alacritty, Rofi, Conky, Picom
* Pixel perfect Terminus.otb 
* Neovim (LSP via coc.nvim): Elixir, JS, HTML, CSS
* https://github.com/ksevelyar/joker.vim (heavily inspired by vim-gotham)
* FZF, Ripgrep, Fish, Tmux, Zeal
* SpaceFM, nnn, nomacs, ncdu
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
* browserpass + gopass
* Proprietary suite: Upwork, Slack, Skype, Google-Chrome, Google-Play-Music-Desktop-Player, Telegram, Memtest, Broadcom Wi-Fi drivers

## rofi with plugins

![](https://i.imgur.com/u2GS8ax.png)

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

https://github.com/ksevelyar/dotfiles/blob/master/live-usb.nix

```
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync
```

## install

```
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
