args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/manya.nix
      ../users/ksevelyar.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/intel.nix
      #../hardware/nvidia.nix
      ../hardware/sound.nix
      #../hardware/jack.nix
      ../hardware/ssd.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/fonts.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/cache.nix

      ../boot/bios.nix
      ../boot/multiboot.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/x-common.nix
      ../packages/dev.nix
      ../packages/3d-print.nix
      ../packages/electronics.nix

      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      ../packages/freelance.nix

      ../services/journald.nix
      ../services/postgresql.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix

      ../services/net/firewall-desktop.nix
      ../services/net/openvpn.nix
      #../services/vpn/vpn.nix
      ../services/net/sshd.nix
      ../services/net/wireguard.nix

      ../services/vm/hypervisor.nix
      # ../services/vm/docker.nix
    ];

  time.timeZone = "Europe/Moscow";
  location.latitude = 55.75;
  location.longitude = 37.61;

  # boot
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";

  boot.blacklistedKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;


  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # net
  networking.hostName = "sobanya";
  networking.interfaces.enp3s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.6" ];
      privateKeyFile = "/home/manya/wireguard-keys/private";
      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # x
  services.xserver = {
    displayManager = {
      defaultSession = "none+leftwm";
    };
    videoDrivers = [ "nouveau" "modesetting" ];
  };


  # hardware

  # fs
  swapDevices = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
  };
}
