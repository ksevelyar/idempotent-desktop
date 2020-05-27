# Live Usb

[live-usb.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb.nix) ~2GB

[live-usb-minimal.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb-minimal.nix) ~900MB

## Create

Install nix with `curl -L https://nixos.org/nix/install | sh` (fot non NixOS users)

Clone repo: `git clone git@github.com:ksevelyar/dotfiles.git ~/ksevelyar-dotfiles && cd ~/ksevelyar-dotfiles`

Generate nixos.iso:

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live-usb.nix

sudo dd bs=4M if=result/iso/nixos.iso of=/dev/sdX status=progress && sync
```

Or

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live-usb-minimal.nix

sudo dd bs=4M if=result/iso/nixos.iso of=/dev/sdX status=progress && sync
```

You can create your own iso on this step, just add new modules and remove things you don't want

## Or just download it

[nixos.iso](https://drive.google.com/file/d/1T1pzVe1y0EykfEeW7w4QbJmwu8HGn45X/view?usp=sharing)
