args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/ksevelyar.nix
      ../users/kh.nix
      ../services/x/openbox.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/fonts.nix

      ../boot/efi.nix
      ../boot/multiboot.nix

      ../services/journald.nix
      ../services/postgresql.nix
      ../services/redis.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix

      ../packages/x-common.nix
      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/3d-print.nix
      ../packages/electronics.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      ../packages/freelance.nix

      ../hardware/bluetooth.nix
      ../hardware/intel.nix
      ../hardware/nvidia.nix
      ../hardware/sound.nix
      (import ../hardware/jack.nix (args // { output = "hw:0,0"; }))
      ../hardware/ssd.nix

      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      # ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      ../services/vpn/vpn.nix
      ../services/net/avahi.nix

      ../services/vm/hypervisor.nix
    ];

  boot.loader.grub.splashImage = ../assets/displayManager.png;
  boot.loader.grub.splashMode = "stretch";

  networking.hostName = "catch-22";
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # mkdir -p ~/wireguard-keys && cd ~/wireguard-keys && umask 077
  # wg genkey | tee private | wg pubkey > public
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.10" ];
      privateKeyFile = "/home/kh/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  # sudo fatlabel /dev/disk/by-uuid/3A05-EA05 boot
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/storage" =
    {
      device = "/dev/disk/by-label/storage";
      fsType = "ntfs";
    };
}
