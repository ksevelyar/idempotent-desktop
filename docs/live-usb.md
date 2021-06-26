# Live Usb

## Download it

[idempotent-desktop.iso](https://drive.google.com/file/d/1XBa1LUK32A_DbMBge44co_AFfg44Ngqo/view?usp=sharing) ~1.7GB

## Generate

```sh
nix build .#nixosConfigurations.live-usb.config.system.build.isoImage

```

## Write it to usb

`sudo dd bs=4M if=result/iso/id-live.iso of=/dev/disk/by-label/id-live status=progress oflag=sync`

You can replace `/dev/disk/by-label/id-live` with `/dev/sdX` with proper device from `lsblk` output.

## Or run with virt-manager

![virt-manager](https://i.imgur.com/1n0SWwG.png)

### Try your usb in vm before reboot

```fish
sudo qemu-kvm -hdb /dev/disk/by-label/id-live
```
