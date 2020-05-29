# λ Idempotent Desktop

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)
![screen](https://i.imgur.com/8WruLfd.png)

🍕 This repo is just a bunch of NixOS [modules](https://github.com/ksevelyar/dotfiles/tree/master/modules), so you can pick or override anything.

🍕 I use NixOS for [development](https://idempotent-desktop.netlify.app/vim.html), as a headless [router](https://github.com/ksevelyar/dotfiles/blob/master/modules/net/router.nix), for my tv (mostly `kodi`) and as a k8s node for my [atoms](https://ark.intel.com/content/www/us/en/ark/products/59682/intel-atom-processor-d2500-1m-cache-1-86-ghz.html).

🍕 You can use `tor` as a free socks5 proxy to bypass government blocks for selected sites.

🍕 You can create your own [live usb](https://idempotent-desktop.netlify.app/live-usb.html)

🍕 You can use these dotfiles in other unix too, check [home](https://github.com/ksevelyar/dotfiles/tree/master/home)

## [Docs](https://idempotent-desktop.netlify.app/)

Feel free to create an issue if something is unclear or broken.

## [More Screenshots](https://idempotent-desktop.netlify.app/screenshots.html)

## Try

Easiest way is to create or download [live-usb](/live-usb)

## Install

I'll point only things that differ from [nixos.org/nixos/manual](https://nixos.org/nixos/manual/)

Physical machines locates in `hosts`; users in `users`. You'll need to link your host to configuration.nix and rebuild system.

Example of fresh installation from `live-usb`:

## Mount drives

```sh
mount /dev/disk/by-label/nixos /mnt
mount /dev/disk/by-label/boot  /mnt/boot

```

## Clone repo

`sudo git clone git@github.com:ksevelyar/dotfiles.git /mnt/etc/nixos`

## Create new user

`nvim /mnt/etc/nixos/hosts/new-host.nix`

You can use [ksevelyar.nix](https://github.com/ksevelyar/dotfiles/blob/master/users/ksevelyar.nix) as reference.

## Generate configs and merge them to new host

```sh
sudo nixos-generate-config --root /mnt
bat /mnt/etc/nixos/*.nix
sudo mv /mnt/etc/nixos{,.bak}

nvim /mnt/etc/nixos/hosts/new-host.nix

```

You can use [hk47.nix](https://github.com/ksevelyar/dotfiles/blob/master/hosts/hk47.nix) as reference.

## Add channels and install nixos

```sh
sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo nixos-install
```
