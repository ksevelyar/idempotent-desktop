# Live Usb

## Generate

```sh
nix build /etc/nixos#nixosConfigurations.live-usb.config.system.build.isoImage    
```

## Write it to usb

`sudo dd bs=4M if=result/iso/id-live.iso of=/dev/disk/by-label/id-live status=progress oflag=sync`

You can replace `/dev/disk/by-label/id-live` with `/dev/sdX` with proper device from `lsblk -f` output.
