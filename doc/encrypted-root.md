# encrypted root

```
sudo su
```

## [Create partitions](https://nixos.org/manual/nixos/stable/index.html#sec-installation-partitioning-UEFI) 

```
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart primary 512MiB 100%
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 2 esp on
```

## Wipe partition for the future /

```
lsblk -f
```

```
dd if=/dev/zero    of=/dev/nvme0n1p2 status=progress
dd if=/dev/urandom of=/dev/nvme0n1p2 status=progress
```

## Create LUKS2 container

```
cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
cryptsetup config /dev/nvme0n1p2 --label enc-nixos
cryptsetup luksOpen /dev/nvme0n1p2 nixos
```

## Mount 

```
mkfs.ext4 -L nixos /dev/mapper/nixos
mount /dev/mapper/nixos /mnt

mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

## Clone configs 

```
git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
chown -R 1000:users /mnt/etc/nixos
```

## Add LUKS2 container to configuration.nix

```
boot.initrd.luks.devices.nixos = {
  device = "/dev/disk/by-label/enc-nixos";
  allowDiscards = true;
};

fileSystems."/" = {
  device = "/dev/disk/by-label/nixos";
  fsType = "ext4";
  options = [ "noatime" "nodiratime" ];
};
```

## Install

```
nixos-install --root /mnt --flake /mnt/etc/nixos#hk47
reboot
```


## Result

```
lsblk -f
```

```
nvme0n1
├─nvme0n1p1 vfat        FAT32 boot      E675-3AA7                             392.1M    21% /boot
├─nvme0n1p2 crypto_LUKS 2     enc-nixos 959a5350-4973-4971-a6e5-b725f1fac59e
│ └─root    ext4        1.0   nixos     090b5f4e-bea7-49cb-9ea2-d667019d9966  156.8G    13% /nix/store
│                                                                                           /
└─nvme0n1p4 ntfs              win10     7492024D92021470
```
