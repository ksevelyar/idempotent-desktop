# Idempotent Desktop

![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)
![tomb](/docs/images/tomb.png)

## [Docs](https://idempotent-desktop.netlify.app/)

This repo is just a bunch of NixOS [modules](https://github.com/ksevelyar/idempotent-desktop/tree/master/modules), so you can pick or override anything.

[Other Screens](https://idempotent-desktop.netlify.app/screenshots.html).

## Features

> Idempotence is the property of certain operations in mathematics and computer science whereby they can be applied multiple times without changing the result beyond the initial application.

### Agnostic DE without actual DE

- `xmonad`, `polybar`, `rofi`, `dunst`, `tmux`, `lxqt-policykit`, and friends
- Opimised for both touch typing and mouse
- Unified look for gtk and qt with `ant-dracula` theme
- Effective usage of resources, requires **less than 500MB RAM** to boot to the graphical user interface
- Install system with all you preferences using three commands

### Friendly for developers and DIY enthusiasts

- `elixir`, `node`, `rust` nix-shell environments
- `mongodb`, `postgresql`
- `docker`

- `arduino-ide`, `esptool.py`, `fritzing`
- `openscad`, `prusa-slicer`

### CLI Tools

- `fish`, `alacritty`
- `fd`, `rg`, `fzf`, `delta`, `bat`
- `jq`
- `hunter`, `ncdu`, `zoxide`
- `tealdeer`
- `ddgr`, `googler`
- `imv`, `mpv`, `viu`, `moc`

### NixOS

- Describe your sysem before installation with text files and put them to git
- Automatic backups after each rebuild
- Autotest all your hosts with Cachix and [CI](https://github.com/ksevelyar/idempotent-desktop/blob/master/.github/workflows/build.yml)

### Security

- Use master password with `gopass` and integrate it to [browser](https://addons.mozilla.org/en-US/firefox/addon/browserpass-ce/)
- Keep your secrets in `tomb`
- See info about `sshd` and `x11vnc` connects in `polybar`

### Anonimity

- Tor Browser Bundle and `onionshare`
- Tor as socks5 proxy for Telegram Desktop and Firefox.
- `openvpn` with `update-resolv-conf` (tested with [protonvpn.com](https://protonvpn.com))
- `wireguard`, `i2p`

### Proprietary suite

Steam, Spotify, Slack, Upwork and others if you need them.

### Games

`games.nix` includes opendune, dwarf-fortress, rogue, nethack, stepmania, wesnoth and wine

### Hackable Live Usb 💾

- [Build](https://idempotent-desktop.netlify.app/live-usb.html)
- [Or Download](https://drive.google.com/file/d/1XBa1LUK32A_DbMBge44co_AFfg44Ngqo/view?usp=sharing)

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
  - [x] Find dark theme for vuepress
- [ ] Declarative Node packages
- [ ] Declarative secrets
- [ ] Pack [Neovide](https://github.com/Kethku/neovide)
- [ ] semantic versioning
