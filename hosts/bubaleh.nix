args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/obstinatekate.nix
      ../users/root.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/amd-gpu.nix
      ../hardware/amd-cpu.nix
      ../hardware/pulseaudio.nix
      ../hardware/ssd.nix
      ../hardware/efi.nix
      ../hardware/multiboot.nix

      ../sys/aliases.nix
      ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/fonts.nix
      ../sys/cache.nix

      ../services/journald.nix
      # ../services/postgresql.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix
      ../services/x/unclutter.nix

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

      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      ../services/net/avahi.nix

      # ../services/vm/hypervisor.nix
    ];

  networking.hostName = "bubaleh";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.51" ];
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

  # boot
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ]; # ssd
  };

  fileSystems."/boot" = {
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
