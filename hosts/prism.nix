{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/obstinatekate.nix
    ../users/root.nix

    ../hardware/bios.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/pulseaudio.nix
    ../hardware/ssd.nix
    ../hardware/multiboot.nix
    # ../hardware/power-management.nix

    ../sys/aliases.nix
    ../sys/debug.nix
    ../sys/nix.nix
    ../sys/scripts.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/fonts.nix
    ../sys/cache.nix

    ../services/journald.nix
    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../packages/x-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/x-common.nix
    ../packages/dev.nix
    # ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    # ../packages/tmux.nix

    ../services/net/firewall-desktop.nix
    ../services/vpn.nix
    ../services/net/wireguard.nix
    ../services/net/sshd.nix
    ../services/net/openvpn.nix
    ../services/net/avahi.nix

    # ../services/vm/hypervisor.nix
  ];

  networking.hostName = "prism";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkDefault true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.50" ];
      privateKeyFile = "/home/obstinatekate/wireguard-keys/private";
      peers = [{
        publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
        allowedIPs = [ "192.168.42.0/24" ];
        endpoint = "95.165.99.133:51821";
        # Send keepalives every 25 seconds. Important to keep NAT tables alive.
        persistentKeepalive = 25;
      }];
    };
  };


  boot.loader.grub.splashImage = ../assets/wallpapers/fractal.png;
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.kernelModules = [ "kvm-intel" ];

  # vpn
  services.openvpn.servers = {
    uk-shark.autoStart = true;
    de-shark.autoStart = false;
    fr-shark.autoStart = false;
    us-proton.autoStart = false;
  };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
  };

  services.xserver = {
    videoDrivers = [ "ati-drivers" ];
    displayManager = {
      sddm.enable = lib.mkForce true;
      lightdm.enable = lib.mkForce false;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ]; # ssd
  };
}
