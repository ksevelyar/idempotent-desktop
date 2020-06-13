# mostly for Travis CI
{ config, pkgs, lib, vars, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
    ./iso.nix

    ../users/shared.nix
    ../users/live-usb.nix

    ../modules/sys/aliases.nix
    ../modules/sys/scripts.nix
    ../modules/sys/tty.nix
    ../modules/sys/debug.nix
    ../modules/sys/vars.nix
    ../modules/sys/sysctl.nix

    ../modules/boot/broadcom-wifi.nix

    ../modules/services/common.nix
    ../modules/services/x.nix

    ../modules/x/xmonad.nix
    ../modules/x/fonts.nix
    ../modules/packages/x-common.nix
    ../modules/packages/x-extra.nix

    ../modules/packages/absolutely-proprietary.nix
    ../modules/packages/common.nix
    ../modules/packages/dev.nix
    ../modules/packages/games.nix
    ../modules/packages/nvim.nix
    ../modules/packages/tmux.nix
    ../modules/packages/firefox.nix
    ../modules/packages/pass.nix

    ../modules/hardware/bluetooth.nix
    ../modules/hardware/sound.nix
    ../modules/hardware/laptop.nix

    ../modules/net/firewall-desktop.nix
    ../modules/net/wireguard.nix
    ../modules/net/i2pd.nix
    # ../modules/net/i2p.nix
    ../modules/net/tor.nix
    ../modules/net/sshd.nix

    # ../modules/vm/hypervisor.nix
  ];

  isoImage.volumeID = lib.mkForce "id-live-max";
  isoImage.isoName = lib.mkForce "id-live-max.iso";
}
