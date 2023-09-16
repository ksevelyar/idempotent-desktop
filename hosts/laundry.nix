# 53013PEW
## F12 for boot menu, F2 for quick boot
args@{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
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
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix
    ../packages/office.nix

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/databases/redis.nix
    ../services/mpd.nix
    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../services/net/firewall-desktop.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/sshd.nix
    # ../services/net/wireguard.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
  ];


  home-manager.users.ksevelyar = {
    # home.file.".config/leftwm/themes/current/up".source = ../users/ksevelyar/leftwm-hk47/up;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # net
  networking.hostName = "laundry";
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  # vpn
  services.openvpn.servers = {
    uk-shark.autoStart = false;
    express.autoStart = false;
  };

  # microbit v2
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE:="666"
  '';

  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/akira.png;

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  # boot.initrd.luks.devices."nixos".device = "/dev/disk/by-uuid/ad804193-1aaf-483f-804c-da5d7030d1c4";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/SYSTEM";
    fsType = "vfat";
    options = [ "noatime" "nodiratime" ];
  };
}
