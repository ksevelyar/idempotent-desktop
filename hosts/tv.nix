args@{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
    ../hardware/intel-gpu.nix
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
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix

    ../services/mpd.nix
    ../services/journald.nix
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
  ];

  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];

  networking.hostName = "tv";
  networking.interfaces.eno1.useDHCP = true;
  networking.useDHCP = false;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.42" ];
      privateKeyFile = "/home/ksevelyar/.secrets/wireguard/private";
      peers = [{
        publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
        allowedIPs = [ "192.168.42.0/24" ];
        endpoint = "95.165.99.133:51821";
        # Send keepalives every 25 seconds. Important to keep NAT tables alive.
        persistentKeepalive = 25;
      }];
    };
  };

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u24n.psf.gz";

  hardware = {
    pulseaudio = {
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
  };

  # J4125 (F11 for boot menu)
  # DIMM DDR4 16GB
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
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

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };
}
