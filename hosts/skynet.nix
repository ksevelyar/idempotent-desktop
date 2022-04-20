{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/intel.nix
    ../hardware/ssd.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/nix.nix
    ../sys/cache.nix

    ../boot/efi.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/nvim.nix
    ../packages/tmux.nix
    ../packages/pass.nix

    ../services/journald.nix
    ../services/net/wireguard.nix
    ../services/net/nfs.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix
  ];

  networking.useDHCP = false;
  networking.interfaces = {
    eno0.useDHCP = true;
  };

  networking.firewall = {
    enable = lib.mkForce true;

    interfaces.enp3s0 = {
      allowedTCPPorts = [
        # wireguard
        51821

        # http, https
        80
        443
      ];
      allowedUDPPorts = [
        # wireguard
        51821
      ];
    };
  };

  systemd.services.sshd.wantedBy = [ "multi-user.target" ];

  # mkdir -p ~/wireguard-keys && cd ~/wireguard-keys && umask 077
  # wg genkey | tee private | wg pubkey > public
  networking.wireguard.interfaces.skynet = {
    ips = [ "192.168.42.1" ];
    listenPort = 51821;

    privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

    peers = [
      # ksevelyar 42-52

      ## tv 
      {
        publicKey = "9VERcnVTfy/hudaCyE/ULhA7KmOOnYGm+VxkFrS9T3k=";
        allowedIPs = [ "192.168.42.42" ];
      }
      ## hk-47 
      {
        publicKey = "Ql36tqX82moc8k5Yx4McF2zxF4QG3jeoXoj8AxSUNRU=";
        allowedIPs = [ "192.168.42.47" ];
      }
      ## laundry 
      {
        publicKey = "ywV4e4436z6mqKCGF2cJdmuYOTeSY2u+GxrZntneNRw=";
        allowedIPs = [ "192.168.42.46" ];
      }
      ## phone
      {
        publicKey = "Z9kuAhDf9i5azQ49VJuSy16ciqDJ0uPhkqkbRykkPSM=";
        allowedIPs = [ "192.168.42.48" ];
      }

      # alesha 110-120
      ## a11dtop
      {
        publicKey = "7Gl9PF+4LUsmOzdY07f9j9m8dV4/RSrqCH8+d2yqhQs=";
        allowedIPs = [ "192.168.42.119" ];
      }

      # kh 10-20
      ## catch-22
      {
        publicKey = "FcxMzEwr5LM30FWy+etfBU5CQScioa4WJSXv7vulIDk=";
        allowedIPs = [ "192.168.42.10" ];
      }
      ## pepes
      {
        publicKey = "dKznTEMMN4xKXuP8UDo92G14pzwrJNGTISeSXoMcTxQ=";
        allowedIPs = [ "192.168.42.11" ];
      }

      # manya
      ## cyberdemon
      {
        publicKey = "3DUHA0EYOaFVjeemwvqYa3wtbLDAc4wPhrPVnXxsdQ0=";
        allowedIPs = [ "192.168.42.4" ];
      }
      ## phone
      {
        publicKey = "Cf1ZnKsJMTYTZfjU0xV+NJCXeOKvBq1/b2O4553Y+Ac=";
        allowedIPs = [ "192.168.42.5" ];
      }
      ## sobanya
      {
        publicKey = "JRIVeD2SXvGF86NrBAur770DADZ9zYO5d7/sCFqjTRM=";
        allowedIPs = [ "192.168.42.6" ];
      }

      # macbook anya
      {
        publicKey = "xrw8dXQlFEt+PuRRZ8uov+6PCpsCW+0nkBk06Erzu0E=";
        allowedIPs = [ "192.168.42.7" ];
      }

      # prism
      {
        publicKey = "FLCkV96NM5ortoqDNiF4eswK1vnLSa04gTnDMmLuaAg=";
        allowedIPs = [ "192.168.42.50" ];
      }
      # bubaleh
      {
        publicKey = "4uOtdM7jlN/JgJIZnz8faCPRoFmBDm1MvPio3woIYCg=";
        allowedIPs = [ "192.168.42.51" ];
      }
    ];
  };

  networking.hostName = "skynet";
  networking.networkmanager.enable = lib.mkForce false;

  boot.loader.grub.splashImage = lib.mkForce ../assets/wallpapers/fractal.png;
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];

  boot.kernelModules = [ "kvm-intel" "tcp_bbr" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_hardened;

  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  # F11 for boot menu
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "noatime" "nodiratime" ]; # ssd
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ]; # ssd
  };
}
