args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/ksevelyar.nix
      ../users/kh.nix
      ../users/root.nix

      ../hardware/efi.nix
      ../hardware/multiboot.nix
      ../hardware/bluetooth.nix
      ../hardware/intel-cpu.nix
      ../hardware/nvidia.nix
      ../hardware/pulseaudio.nix
      ../hardware/ssd.nix

      # ../sys/debug.nix
      ../sys/aliases.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/fonts.nix
      ../sys/cache.nix

      ../services/journald.nix
      ../services/databases/postgresql.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix
      ../services/x/unclutter.nix

      ../packages/x-common.nix
      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/3d-print.nix
      ../packages/electronics.nix
      ../packages/games.nix
      ../packages/neovim.nix
      ../packages/pass.nix
      ../packages/tmux.nix

      ../services/net/firewall-desktop.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      ../services/vpn.nix
      ../services/net/avahi.nix

      # ../services/vm/hypervisor.nix
    ];

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  networking.hostName = "catch-22";
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.10" ];
      privateKeyFile = "/home/kh/wireguard-keys/private";
      peers = [{
          publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          persistentKeepalive = 25;
      }];
    };
  };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
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

  fileSystems."/storage" = {
    device = "/dev/disk/by-label/storage";
    fsType = "ntfs";
  };
}
