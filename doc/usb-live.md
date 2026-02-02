# Live usb drive

## Build

```
nix build .#nixosConfigurations.usb-image.config.system.build.isoImage
```

## Write
```
lsblk -f

sudo dd bs=4M if=result/iso/nixos-minimal-25.11.20260128.fa83fd8-x86_64-linux.iso of=/dev/sdx status=progress oflag=sync
```

## Analyze
```
nix eval .#nixosConfigurations.usb-image.config.environment.systemPackages

nix build .#nixosConfigurations.usb-image.config.system.build.toplevel
nix-tree .#nixosConfigurations.usb-image.config.system.build.toplevel
```
