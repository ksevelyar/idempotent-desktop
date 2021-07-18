args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/ksevelyar.nix
      ../services/x/openbox.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/intel.nix
      ../hardware/nvidia.nix
      ../hardware/sound.nix
      # ../hardware/jack.nix
      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/fonts.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix

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
      ../packages/freelance.nix
      ../packages/mail.nix

      ../services/journald.nix
      ../services/postgresql.nix
      ../services/redis.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix

      ../services/net/firewall-desktop.nix
      (import ../services/net/nginx.nix { email = "ksevelyar@gmail.com"; })
      ../services/net/openvpn.nix
      ../services/vpn/vpn.nix
      ../services/net/sshd.nix
      # ../services/net/tor.nix
      ../services/net/wireguard.nix
      ../services/net/avahi.nix

      ../services/vm/hypervisor.nix
    ];

  # boot
  boot.loader.grub.splashImage = ../assets/displayManager.png;
  boot.loader.grub.splashMode = "stretch";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = false; # run nmtui for wi-fi
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.47" ];
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";
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
  services.xserver.displayManager.defaultSession = "none+xmonad";

  # hardware
  ## i5-9400F
  ## PRIME B360M-K
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

  # fs
  swapDevices = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/storage" =
    {
      device = "/dev/disk/by-label/storage";
      fsType = "ext4";
      options = [ "noatime" ];
    };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };
}
