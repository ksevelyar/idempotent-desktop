args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/ksevelyar.nix
      ../users/root.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/intel.nix
      ../hardware/nvidia.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/fonts.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/cache.nix

      ../boot/efi.nix
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

      ../services/journald.nix
      ../services/postgresql.nix
      ../services/mpd.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix
      ../services/x/unclutter.nix

      ../services/net/firewall-desktop.nix
      ../services/net/openvpn.nix
      ../services/vpn/vpn.nix
      ../services/net/sshd.nix
      ../services/net/wireguard.nix
      ../services/net/avahi.nix

      # ../services/vm/hypervisor.nix
    ];

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = false; # run nmtui for wi-fi
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.47" ];
      privateKeyFile = "/home/ksevelyar/.secrets/wireguard-keys/private";
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

  # vpn
  services.openvpn.servers = {
    uk-shark = {
      autoStart = false;
    };
    de-shark = {
      autoStart = false;
    };
    fr-shark = {
      autoStart = true;
    };
    us-proton = {
      autoStart = false;
    };
  };

  # x
  services.xserver.displayManager.defaultSession = "none+leftwm";

  # hardware
  ## i5-9400F
  ## PRIME B360M-K (F8 for boot menu)
  ## RTX 2060
  ## DIMM DDR4 2133MHz 16GBx2
  hardware = {
    pulseaudio = {
      configFile = ../users/shared/disable-hdmi.pa;
      extraConfig = ''
        load-module module-switch-on-connect
        set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
      '';
    };
  };

  # boot
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # fs
  swapDevices = [ ];

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
    options = [ "noatime" "nodiratime" ]; # ssd
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };
}
