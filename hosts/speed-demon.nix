# F12 - boot menu
args @ {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/kavarkon.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/amd-cpu.nix
    ../hardware/amd-gpu.nix
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
    ../services/x.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../services/net/firewall-desktop.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
  ];

  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
    jdk17
  ];

  home-manager.users.kavarkon = {
    home.file.".config/polybar/config.ini".source = ../users/kavarkon/speed-demon/polybar.ini;
  };

  networking.hostName = "speed-demon";
  networking.useDHCP = true;

  services = {
    syncthing = {
      enable = true;
      user = "kavarkon";
      dataDir = "/home/kavarkon/syncthing";
      configDir = "/home/kavarkon/.config/syncthing";
    };
  };

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.configurationLimit = 3;
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
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

  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/akira.png;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

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
}
