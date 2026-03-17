args @ {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/kh.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/intel-cpu.nix
    ../hardware/nvidia.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix

    ../sys/aliases.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/fonts.nix

    ../packages/wayland-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/games-retro.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/spotify.nix

    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/wayland/hyprland.nix
    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix
  ];

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.kh-xray-json.path;
  };

  environment.systemPackages = with pkgs; [
    foliate
    obsidian
    gnumake
    spaceFM
    google-chrome
  ];

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];

  networking.hostName = "catch-22";
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # NOTE: enable F keys on startup
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  home-manager.users.kh = {
    home.file.".config/hypr/hypridle.conf".source = ../users/kh/catch-22/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/kh/catch-22/hypr/hyprland.conf;
    home.file.".config/waybar/config".source = ../users/ksevelyar/hk47/waybar/waybar.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/hk47/waybar/waybar.css;
    home.file.".config/alacritty/alacritty.toml".source = ../users/kh/catch-22/alacritty.toml;
  };

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
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
  };
}
