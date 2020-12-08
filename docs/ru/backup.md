# Резервное копирование с rsync и dm_crypt

## Подготовка usb

Создайте 2 раздела, публичный `/sdx/sdx1` и зашифрованный `/sdx/sdx2`.
Это можно сделать с помощью `gparted` или `cfdisk`.

## Шифрование sdx2

```fish
sudo cryptsetup luksFormat /dev/sdx2
sudo cryptsetup config /dev/sdx2 --label secrets

cryptsetup luksOpen /dev/sdx2 secrets
sudo mkfs.ext4 -L secrets /dev/mapper/secrets
```

## Создание резервной копии

```fish
sudo chown ksevelyar:nobody /run/media/ksevelyar/secrets/
rsync -ra --info=progress2 --delete --exclude-from=/etc/nixos/home/rsync-exclude.txt --delete ~ /run/media/ksevelyar/secrets
```

## Создание архива со 🐖🐖

```fish
cd /run/media/ksevelyar/secrets
tar cf - home | pigz > home-(date +'%m-%d-%Y').tar.xz

```

## Отмонтирование флешки

```fish
sudo umount /dev/mapper/secrets
sudo cryptsetup luksClose secrets
```
