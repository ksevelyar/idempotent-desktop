# Persistent usb drive

## Find usb by id

```
ls -l /dev/disk/by-id/
```

## Install TUI system

```
sudo nix run 'github:nix-community/disko/latest#disko-install' -- --flake '.#usb' --disk main /dev/disk/by-id/usb-_USB_DISK_3.0_BACDB3AA46FC8667-0:0
```

# Install X system

```
sudo nix run 'github:nix-community/disko/latest#disko-install' -- --flake '.#usb-x' --disk main /dev/disk/by-id/usb-_USB_DISK_3.0_BACDB3AA46FC8667-0:0
```
