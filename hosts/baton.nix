# LNVNB161216
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
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
    ../hardware/intel-gpu.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix
    ../hardware/power-management.nix

    ../sys/aliases.nix
    ../sys/fonts.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/wayland-common.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix

    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/wayland/hyprland.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix
    ../services/net/dns.nix

    ../services/vm/docker.nix
  ];

  networking.hostName = "baton";
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  # networking.proxy.default = "127.0.0.1:2080";

  programs.java = { enable = true; package = pkgs.jdk17; };
  environment.systemPackages = with pkgs; [
    gradle
    discord-canary
  ];

  # http://localhost:8384/
  services = {
    syncthing = {
      enable = true;
      user = "kavarkon";
      dataDir = "/home/kavarkon/syncthing";
      configDir = "/home/kavarkon/.config/syncthing";
    };
  };

  home-manager.users.kavarkon = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/laundry/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/laundry/hypr/hyprland.conf;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/laundry/waybar/waybar-top.json;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/laundry/waybar/waybar-bottom.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/laundry/waybar/waybar.css;

    home.file.".config/alacritty/alacritty.toml".source = ../users/ksevelyar/laundry/alacritty/alacritty.toml;
  };

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.configurationLimit = 3;
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.kavarkon-xray-json.path;
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
