# Backup

## Encrypt usb drive

```fish
sudo cryptsetup luksFormat /dev/sdc2
sudo cryptsetup config /dev/sdc2 --label secrets

cryptsetup luksOpen /dev/sdc2 secrets
sudo mkfs.ext4 -L secrets /dev/mapper/secrets
```

## Create backup

```fish
sudo chown ksevelyar:nobody /run/media/ksevelyar/secrets/
rsync -ra --info=progress2 --delete --exclude-from=/etc/nixos/home/rsync-exclude.txt --delete ~ /run/media/ksevelyar/secrets

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
