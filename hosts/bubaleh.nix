args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/obstinatekate.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/amd-gpu.nix
      ../hardware/amd-cpu.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/fonts.nix

      ../boot/efi.nix
      ../boot/multiboot.nix

      ../services/journald.nix
      ../services/postgresql.nix
      # ../services/redis.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix

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

      ../services/net/fail2ban.nix
      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      ../services/net/avahi.nix

      # ../services/vm/hypervisor.nix
    ];

  boot.loader.grub.splashImage = ../assets/displayManager.png;
  boot.loader.grub.splashMode = "stretch";

  # boot
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  networking.hostName = "bubaleh";
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.51" ];
      privateKeyFile = "/home/obstinatekate/wireguard-keys/private";

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
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkDefault true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };
}