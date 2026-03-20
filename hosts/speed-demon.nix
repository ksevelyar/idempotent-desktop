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
    ../hardware/multiboot.nix

    ../sys/aliases.nix
    ../sys/fonts.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/wayland-common.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/office.nix

    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/wayland/hyprland.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
  ];

  programs.java = { enable = true; package = pkgs.jdk17; };
  environment.systemPackages = with pkgs; [
    jdk17
    # discord-canary
    inkscape
  ];

  home-manager.users.kavarkon = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/hk47/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/kavarkon/speed-demon/hypr/hyprland.conf;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/hk47/waybar/waybar-bottom.json;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/hk47/waybar/waybar-top.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/hk47/waybar/waybar.css;
  };

  networking.hostName = "speed-demon";
  networking.useDHCP = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.kavarkon-xray-json.path;
  };

  # http://localhost:8384/
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
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };
}
