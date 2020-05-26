# live usb

[live-usb.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb.nix) ~2GB

[live-usb-minimal.nix](https://github.com/ksevelyar/dotfiles/blob/master/live-usb-minimal.nix) ~900MB

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync
