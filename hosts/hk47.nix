# hardware
## PRIME B360M-K (F8 for boot menu)
## i5-9400F
## RTX 2060
## DIMM DDR4 2133MHz 16GBx2
## RTL8812A: set bssid with nmtui to fix disconnects: deauthenticating (Reason: DEAUTH_LEAVING)
## RTL8812A: nmcli -f in-use,ssid,bssid,signal,rate,bars dev wifi

args@{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
    ../hardware/nvidia.nix
    ../hardware/pulseaudio.nix
    ../hardware/ssd.nix

    ../sys/aliases.nix
    ../sys/fonts.nix
    ../sys/nix.nix
    ../sys/scripts.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/cache.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/x-common.nix
    ../packages/dev.nix
    ../packages/2d-graphics.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix
    ../packages/office.nix

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/databases/redis.nix
    ../services/mpd.nix
    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../services/net/firewall-desktop.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
  ];


  home-manager.users.ksevelyar = {
    home.file.".config/leftwm/themes/current/up".source = ../users/ksevelyar/leftwm-hk47/up;
  };

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.47" ];
      privateKeyFile = "/home/ksevelyar/.secrets/wireguard-keys/private";
      peers = [{
        publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
        allowedIPs = [ "192.168.42.0/24" ];
        endpoint = "95.165.99.133:51821";
        # Send keepalives every 25 seconds. Important to keep NAT tables alive.
        persistentKeepalive = 25;
      }];
    };
  };

  # vpn
  services.openvpn.servers = {
    uk-shark.autoStart = false;
    express.autoStart = false;
  };

  # microbit v2
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE:="666"
  '';

  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
    data = {
      device = "/dev/disk/by-label/enc-data";
      allowDiscards = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };
}
