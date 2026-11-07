# Persistent usb drive

## 1. Find usb by id
```
ls -l /dev/disk/by-id/
```

## 2. Install
```
sudo disko-install --flake '.#usb-persistent' --disk main /dev/disk/by-id/usb-_USB_DISK_3.0_BACDB3AA46FC8667-0:0
```
