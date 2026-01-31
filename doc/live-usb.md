# Live Usb

## Tui

```sh
nix build /etc/nixos#nixosConfigurations.live-usb-min.config.system.build.isoImage
```

## X

```sh
nix build /etc/nixos#nixosConfigurations.live-usb-x.config.system.build.isoImage
```

## Write
```
lsblk -f
sudo dd bs=4M if=result/iso/live-usb.iso of=/dev/sdX status=progress oflag=sync
```

## Analyze
```
nix eval .#nixosConfigurations.live-usb-tui.config.environment.systemPackages

nix build .#nixosConfigurations.live-usb-tui.config.system.build.toplevel
nix-tree .#nixosConfigurations.live-usb-tui.config.system.build.toplevel
```
