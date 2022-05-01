# nix build /etc/nixos#nixosConfigurations.live-usb-min.config.system.build.isoImage    
{ config, pkgs, lib, ... }:
{
  imports = [
    ../users/live-usb.nix
    ../users/root.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/sysctl.nix
    ../sys/cache.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/neovim.nix
    ../packages/tmux.nix
    ../packages/pass.nix

    ../hardware/broadcom-wifi.nix
    ../hardware/bluetooth.nix

    ../services/net/sshd.nix
    ../services/net/avahi.nix # ssh -p 9922 root@id-live-min.local
  ];

  isoImage.volumeID = lib.mkForce "id-live-min";
  isoImage.isoName = lib.mkForce "id-live-min.iso";

  fonts.fonts = with pkgs; [ terminus_font ];

  networking.hostName = lib.mkForce "id-live-min";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;
}
