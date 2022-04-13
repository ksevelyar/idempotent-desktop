# Live Usb

## Generate

```sh
nix build /etc/nixos#nixosConfigurations.live-usb.config.system.build.isoImage    
```

or

```sh
nix build /etc/nixos#nixosConfigurations.live-usb-min.config.system.build.isoImage
```

## Write it to usb

`lsblk -f`

`sudo dd bs=4M if=result/iso/id-live.iso of=/dev/sdX status=progress oflag=sync`
