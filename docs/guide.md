# Idempotent Desktop

[![Build Status](https://travis-ci.org/ksevelyar/idempotent-desktop.svg?branch=master)](https://travis-ci.org/ksevelyar/idempotent-desktop)

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)
![screen](https://i.imgur.com/8WruLfd.png)

## [Other Screens](https://idempotent-desktop.netlify.app/screenshots.html)

## Features

> Idempotence is the property of certain operations in mathematics and computer science whereby they can be applied multiple times without changing the result beyond the initial application.

### NixOS

- Nix: Doom Slayer in Dependency Hell.
- Syntaсtic sugar over linux configuration. Describe your sysem before installation and put it to git.
- Automatic backups after each rebuild.
- Autotest all your Linux configurations with Cachix and CI. Reuse binary caches for fast builds.

### Agnostic DE without actual DE

- `xmonad`, `polybar`, `rofi`, `dunst`, `tmux`, `lxqt-policykit`, and friends
- Opimised for both keyboard and mouse
- Unified look for gtk and qt with `ant-dracula` theme
- Effective usage of resources, requires **less than 500MB RAM** to boot to the graphical user interface.
- Install system with all you preferences using three commands

### Security

- Use master password with `gopass` or `keepassxc` (both has browser integration)
- Keep your secrets in `tomb`
- See info about `sshd` and `x11vnc` connects in `polybar`
- Use hardened kernel

### Anonimity

- Tor Browser Bundle and `onionshare`
- Tor as socks5 proxy for Telegram Desktop and Firefox.
- `openvpn`, `wireguard`, `i2p`

### Proprietary suite

Steam, Spotify, Slack, Upwork and others if you need them.

### Games

`games.nix` includes opendune, dwarf-fortress, rogue, nethack, stepmania, wesnoth and wine

### Hackable Live Usb 💾

- [Build](https://idempotent-desktop.netlify.app/live-usb.html)
- [Or Download](https://drive.google.com/file/d/1XBa1LUK32A_DbMBge44co_AFfg44Ngqo/view?usp=sharing)

## [Docs](https://idempotent-desktop.netlify.app/)

🍕 This repo is just a bunch of NixOS [modules](https://github.com/ksevelyar/idempotent-desktop/tree/master/modules), so you can pick or override anything.

🍕 I use NixOS for [development](https://idempotent-desktop.netlify.app/vim.html), as a headless [router](https://github.com/ksevelyar/idempotent-desktop/blob/master/modules/net/router.nix), for my tv (mostly `kodi`) and as a k8s node for my [atoms](https://ark.intel.com/content/www/us/en/ark/products/59682/intel-atom-processor-d2500-1m-cache-1-86-ghz.html). Raspberry Pi also in the list.

🍕 You can use [tor](https://idempotent-desktop.netlify.app/anonymity.html#use-tor-as-a-socks5-proxy), [i2pd](https://idempotent-desktop.netlify.app/anonymity.html#i2p), `wireguard` or `openvpn` to bypass government blocks of selected sites.

🍕 You can use these dotfiles in other unix too, check [home](https://github.com/ksevelyar/idempotent-desktop/tree/master/home)

Feel free to create an issue if something is unclear or broken.

## Quick install

Boot from live-usb. You can prepare drives with `gparted` (`Win` for app launcher).

### Internet

Internet connection is required.

You can connect to wi-fi with `nmtui` from terminal (`Win+Enter` for terminal)

Run `refresh` to update channels.

### Mount drives (EFI)

```fish
mount /dev/disk/by-label/nixos /mnt
mount /dev/disk/by-label/boot  /mnt/boot

```

### Clone repo to /mnt/etc/nixos

```fish
sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
```

### Link your machine

```fish
cd /mnt/etc/nixos
ln -s hosts/hk47.nix configuration.nix
```

### Install

```fish
sudo nixos-install
```

NixOS will ask root password on successful installation

### Finalize user

Set password and correct rights to /etc/nixos for your user:

```fish
sudo passwd username
sudo chown 1000:1000 /mnt/etc/nixos
```

Now you can reboot to your system with `reboot`.

## More verbose installation with new host and user generation

Physical machines locates in `hosts`; users in `users`. You'll need to link your host to configuration.nix and rebuild system.

Example of fresh installation from `live-usb`:

### Clone repo

`sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos`

### Create new user

`nvim /mnt/etc/nixos/users/new-user.nix`

You can use [ksevelyar.nix](https://github.com/ksevelyar/idempotent-desktop/blob/master/users/ksevelyar.nix) as reference.

### Generate configs and merge them to new host

```sh
sudo nixos-generate-config --root /mnt
bat /mnt/etc/nixos/*.nix
sudo mv /mnt/etc/nixos{,.bak}

nvim /mnt/etc/nixos/hosts/new-host.nix

```

You can use [hk47.nix](https://github.com/ksevelyar/idempotent-desktop/blob/master/hosts/hk47.nix) as reference.

### Add channels and install nixos

```sh
sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo nixos-install
```

You should see prompt for root password in the end.

### Scripts and aliases can save some time

- [scripts.nix](https://github.com/ksevelyar/idempotent-desktop/blob/master/modules/sys/scripts.nix)
- [aliases.nix](https://github.com/ksevelyar/idempotent-desktop/blob/master/modules/sys/aliases.nix)

## Todo 🍒

- [ ] Live Usb with persistence layer
- [ ] Write docs
  - [ ] Русская документация
  - [ ] Add animated svgs to docs
  - [ ] Find dark theme for vuepress
- [ ] Declarative Node packages
- [ ] Declarative secrets
- [ ] Pack [Neovide](https://github.com/Kethku/neovide)
- [ ] semantic versioning
