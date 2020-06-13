# FIXME
{ config, pkgs, lib, vars, ... }:
{
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnsupportedSystem = true; # build arm from x64
  # nixpkgs = rec {
  # crossSystem = (import <nixpkgs> {}).pkgsCross.aarch64-multiplatform.stdenv.targetPlatform;
  # localSystem = crossSystem;
  # };

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    # <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi.nix>
    # ./iso.nix

    # ../users/shared.nix
    # ../users/live-usb.nix

    # ../modules/sys/aliases.nix
    # ../modules/sys/scripts.nix
    # ../modules/sys/tty.nix
    # ../modules/sys/debug.nix
    # ../modules/sys/vars.nix
    # ../modules/sys/sysctl.nix

    # ../modules/services/common.nix
    # ../modules/services/x.nix

    # ../modules/x/xmonad.nix
    # ../modules/x/fonts.nix
    # ../modules/packages/x-common.nix
    # # ../modules/packages/x-extra.nix

    # ../modules/packages/absolutely-proprietary.nix
    # ../modules/packages/common.nix
    # # ../modules/packages/dev.nix
    # ../modules/packages/games.nix
    # ../modules/packages/nvim.nix
    # ../modules/packages/tmux.nix
    # ../modules/packages/firefox.nix
    # ../modules/packages/pass.nix

    # ../modules/hardware/bluetooth.nix
    # ../modules/hardware/sound.nix
    # ../modules/hardware/laptop.nix

    # ../modules/net/firewall-desktop.nix
    # ../modules/net/wireguard.nix
    # ../modules/net/i2pd.nix
    # # ../modules/net/i2p.nix
    # ../modules/net/tor.nix
    # ../modules/net/sshd.nix

    # ./modules/vm/hypervisor.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  sdImage.imageBaseName = lib.mkForce "id-live-arm";
  sdImage.imageName = lib.mkForce "id-live-arm.iso";
}
