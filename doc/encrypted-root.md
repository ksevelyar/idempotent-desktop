# encrypted root

## Wipe drives

```
sudo lsblk -f

dd if=/dev/zero    of=/dev/nvme0n1p2 status=progress
dd if=/dev/urandom of=/dev/nvme0n1p2 status=progress
```

## LUKS2 container

```
cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 vault
```

## LVM

```
pvcreate /dev/mapper/vault
vgcreate vg /dev/mapper/vault

lvcreate -l '100%FREE' -n nixos vg

lvdisplay
```

## Mount 

```
mkfs.ext4 -L nixos /dev/vg/nixos
mount /dev/vg/nixos /mnt

mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

## Clone configs 

```
sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
sudo chown -R 1000:users /etc/nixos
```

## Add luksroot to configuration.nix

```
lsblk -f
```

```
nvme0n1
├─nvme0n1p1    vfat        FAT32    boot    E675-3AA7                           
├─nvme0n1p2    crypto_LUKS 2                cdee4fa1-9a7d-4c78-8212-ffc5b52c35fd
│ └─luksroot   LVM2_member LVM2 001         Y7EGJI-Ib8y-62Zh-EKn0-7bdD-Lwtd-OPmUDM
│   └─vg-nixos ext4        1.0      nixos   1430f940-2f70-4c7d-8161-3e3c10e13d4c    
```

```
boot.initrd.luks.devices.luksroot = {
  device = "/dev/disk/by-uuid/cdee4fa1-9a7d-4c78-8212-ffc5b52c35fd";
  preLVM = true;
  allowDiscards = true;
};
```

## Install

```
nixos-install --root /mnt --flake /mnt/etc/nixos#hk47
```
