# nix build /etc/nixos#nixosConfigurations.live-usb.config.system.build.isoImage
args@{ config, pkgs, lib, ... }:
{
  imports = [
    ../users/live-usb.nix
    ../users/root.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/sysctl.nix
    ../sys/fonts.nix
    ../sys/cache.nix

    ../packages/x-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/neovim.nix
    ../packages/tmux.nix
    ../packages/pass.nix

    ../hardware/broadcom-wifi.nix
    ../hardware/bluetooth.nix
    ../hardware/pulseaudio.nix

    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/net/wireguard.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix # ssh -p 9922 root@id-live.local
    ../services/net/openvpn.nix
  ];

  isoImage.volumeID = lib.mkForce "id-live";
  isoImage.isoName = lib.mkForce "id-live.iso";

  networking.hostName = lib.mkForce "id-live";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;

  services.displayManager = {
    autoLogin = { enable = true; user = "mrpoppybutthole"; };
  };
  services.xserver = {
    videoDrivers = [ "nvidia" "nouveau" "amdgpu" "vesa" "modesetting" ];
  };
}
