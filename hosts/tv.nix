args@{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/ksevelyar.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/intel.nix
      ../hardware/intel-gpu.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/fonts.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/debug.nix
      ../sys/cache.nix

      ../boot/efi.nix

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
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix

      ../services/net/firewall-desktop.nix
      ../services/net/openvpn.nix
      # ../services/vpn/vpn.nix
      ../services/net/sshd.nix
      ../services/net/wireguard.nix
      ../services/net/avahi.nix
    ];

  console.font =
    "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  services.xserver.dpi = 180;
  environment.variables = {
    GDK_SCALE = "1.5";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  # boot
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # net
  systemd.services.sshd.wantedBy = [ "multi-user.target" ];
  networking.hostName = "tv";
  networking.interfaces.eno1.useDHCP = true;
  networking.useDHCP = false;


  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.42" ];
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
  services.xserver.displayManager.defaultSession = "none+leftwm";

  # hardware
  ## J4125 (F11 for boot menu)
  ## DIMM DDR4 16GB
  hardware = {
    pulseaudio = {
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
  };

  # fs
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
    options = [ "noatime" "nodiratime" ]; # ssd
  };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };
}
