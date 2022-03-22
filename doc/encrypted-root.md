# encrypted root

# Wipe

dd if=/dev/zero    of=/dev/sdb status=progress
dd if=/dev/urandom of=/dev/sda status=progress


# LUKS2

## container

cryptsetup luksFormat --type luks2 /dev/disk/by-label/vault
cryptsetup luksOpen /dev/disk/by-label/vault vault

## lvm

pvcreate /dev/mapper/vault
vgcreate vg /dev/mapper/vault

lvcreate -l '100%FREE' -n nixos vg

lvdisplay


mkfs.ext4 -L nixos /dev/vg/nixos

mount /dev/vg/nixos /mnt
