# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    ./iso.nix

    ../users/shared.nix
    ../users/live-usb.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/vars.nix
    ../sys/sysctl.nix

    # ../services/x.nix

    #../services/x/openbox.nix
    #../sys/fonts.nix
    #../packages/x-common.nix
    #../packages/x-extra.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    #../packages/dev.nix
    #../packages/games.nix
    ../packages/nvim.nix
    ../packages/tmux.nix
    ../packages/pass.nix

    ../hardware/bluetooth.nix
    #../hardware/sound.nix
    #../hardware/power-management.nix

    ../hardware/broadcom-wifi.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    #../services/net/i2pd.nix
    #../services/net/i2p.nix
    #../services/net/tor.nix
    ../services/net/sshd.nix

    #../services/vm/hypervisor.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  isoImage.volumeID = lib.mkForce "id-live-term";
  isoImage.isoName = lib.mkForce "id-live-term.iso";
}
