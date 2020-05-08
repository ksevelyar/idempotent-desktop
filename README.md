# λ Idempotent Freelancer Desktop 

NixOS, Xmonad, Polybar, Neovim, Fish | Elixir, JS

## neofetch

![screen](https://i.imgur.com/HU6YF0L.png)

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

## glava + gpmdp

![screen](https://i.imgur.com/E1Z5XFo.png)

## conky + gpmdp + taskwarrior

![screen](https://i.imgur.com/fWKORz4.png)

## nebula + iftop

![screen](https://i.imgur.com/V99iRiB.png)

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
