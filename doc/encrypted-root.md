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

## Generate blank config to pick luks/lvm setup from it

```
sudo nixos-generate-config --root /mnt
sudo mv /mnt/etc/nixos{,-blank}
```

## Merge configs and install

```
sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
sudo chown -R 1000:users /etc/nixos

nixos-install --root /mnt --flake /mnt/etc/nixos#.
```
