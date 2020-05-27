# Live Usb

## Download it

[nixos.iso](https://drive.google.com/file/d/1T1pzVe1y0EykfEeW7w4QbJmwu8HGn45X/view?usp=sharing) ~2GB

## Or generate

Install nix with `curl -L https://nixos.org/nix/install | sh` (for non NixOS users)

Clone repo: `git clone git@github.com:ksevelyar/dotfiles.git ~/ksevelyar-dotfiles && cd ~/ksevelyar-dotfiles`

Generate [nixos.iso](https://github.com/ksevelyar/dotfiles/blob/master/live-usb.nix) ~2GB:

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live-usb.nix

```

[Or minimal version without X](https://github.com/ksevelyar/dotfiles/blob/master/live-usb-minimal.nix) ~900MB:

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live-usb-minimal.nix
```

You can generate your own iso, just add new modules and remove things you don't want

## Write it to usb

`sudo dd bs=4M if=result/iso/nixos.iso of=/dev/sdX status=progress && sync`

Replace `/dev/sdX` to proper device from `lsblk` output.

## Or run with virt-manager

![virt-manager](https://i.imgur.com/1n0SWwG.png)
