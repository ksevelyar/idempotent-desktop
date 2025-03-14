# hardware
## PRIME B360M-K (F8 for boot menu)
## i5-9400F
## RTX 2060
## DIMM DDR4 2133MHz 16GBx2
args @ {
  config,
  lib,
  pkgs,
  agenix,
  ...
}: {
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
    ../hardware/nvidia.nix
    ../hardware/pipewire.nix
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
    # ../packages/2d-graphics.nix
    ../packages/3d-print.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    # ../packages/tmux.nix
    ../packages/spotify.nix

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/databases/redis.nix
    ../services/x.nix
    # ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../services/net/firewall-desktop.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    # ../services/net/sing-box.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
    # ../services/vm/hypervisor.nix
  ];

  services.xserver.dpi = 100;

  home-manager.users.ksevelyar = {
    home.file.".config/leftwm/themes/current/up".source = ../users/ksevelyar/hk47/leftwm/up;
  };

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  # http://localhost:8384/
  services = {
    syncthing = {
      enable = true;
      user = "ksevelyar";
      dataDir = "/home/ksevelyar/syncthing";
      configDir = "/home/ksevelyar/.config/syncthing";
    };
  };

  services.udev.extraRules = ''
    # microbit v2
    ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="660", GROUP="dialout"

    # STMicroelectronics ST-LINK/V2
    ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="660", GROUP="dialout"
  '';

  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
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
    options = ["noatime" "nodiratime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = ["noatime" "nodiratime"];
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = ["noatime" "nodiratime"];
  };

  fileSystems."/win" = {
    device = "/dev/disk/by-label/win10";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };
}
