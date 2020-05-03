# neofetch

![screen](https://i.imgur.com/HU6YF0L.png)

# neovim + tmux (via xmonad scratchpad)

![screen](https://i.imgur.com/z95oCew.png)

# spacefm

![screen](https://i.imgur.com/h2nnCWM.png)

# google-chrome, gotop, gpmdp

![screen](https://i.imgur.com/wiIFOdI.png)

# firefox

![screen](https://i.imgur.com/BYpqCbi.png)

# steam

![screen](https://i.imgur.com/GxNoW6l.png)

# doom 2

![screen](https://i.imgur.com/xXcIXu0.png)

# cava + gpmdp

![screen](https://i.imgur.com/Yvq668e.png)

# glava + gpmdp

![screen](https://i.imgur.com/E1Z5XFo.png)

# conky + gpmdp + taskwarrior

![screen](https://i.imgur.com/fWKORz4.png)

# nebula + iftop

![screen](https://i.imgur.com/V99iRiB.png)

# live usb

```
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync
```

# install

```
sudo cp -ra /etx/nixos{,.bak}
sudo mkdir -p /storage/tmp
sudo git clone git@github.com:ksevelyar/dotfiles.git /etc/nixos

sudo nixos-generate-config --root /tmp

sudo nix-channel --add https://nixos.org/channels/nixos-19.09 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo nixos-rebuild switch --keep-going
```
