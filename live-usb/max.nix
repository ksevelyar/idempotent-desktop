{ config, pkgs, lib, vars, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
    ./iso.nix

    ../users/shared.nix
    ../users/live-usb.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/vars.nix
    ../sys/sysctl.nix
    ../sys/fonts.nix


    ../services/x.nix
    ../services/x/xmonad.nix
    ../packages/x-common.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/dev.nix
    ../packages/games.nix
    ../packages/nvim.nix
    ../packages/tmux.nix
    ../packages/firefox.nix
    ../packages/pass.nix

    ../hardware/broadcom-wifi.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    ../hardware/power-management.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    ../services/net/tor.nix
    ../services/net/sshd.nix

    # ../services/vm/hypervisor.nix
  ];

  isoImage.volumeID = lib.mkForce "id-live-max";
  isoImage.isoName = lib.mkForce "id-live-max.iso";
}
