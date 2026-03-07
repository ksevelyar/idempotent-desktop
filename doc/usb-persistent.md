# Persistent usb drive

## Find usb by id

```
ls -l /dev/disk/by-id/
```

## Install TUI system

```
sudo disko-install --flake '.#usb-tui' --disk main /dev/disk/by-id/usb-_USB_DISK_3.0_BACDB3AA46FC8667-0:0
```

# Install Wayland system

```
sudo disko-install --flake '.#usb-hyprland' --disk main /dev/disk/by-id/usb-_USB_DISK_3.0_BACDB3AA46FC8667-0:0
```
