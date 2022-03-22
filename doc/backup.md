# Backup with rsync and dm_crypt

## Prepare usb

Create 2 partitions, public `/sdx/sdx1` and encrypted `/sdx/sdx2`.
You can do it with `gparted` or `cfdisk`.

## Encrypt sdx2

```fish
sudo cryptsetup luksFormat /dev/sdx2
sudo cryptsetup config /dev/sdx2 --label secrets

cryptsetup luksOpen /dev/sdx2 secrets
sudo mkfs.ext4 -L secrets /dev/mapper/secrets
```

## Create backup

```fish
sudo chown ksevelyar:nobody /run/media/ksevelyar/secrets/
rsync -ra --info=progress2 --delete --exclude-from=/etc/nixos/users/shared/rsync-exclude.txt --delete ~ /run/media/ksevelyar/secrets
```

## Freeze it with 🐖🐖

```fish
cd /run/media/ksevelyar/secrets
tar cf - home | pigz > home-(date +'%m-%d-%Y').tar.xz

```

## Unmount usb drive

```fish
sudo umount /dev/mapper/secrets
sudo cryptsetup luksClose secrets
```
