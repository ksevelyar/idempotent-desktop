# N5105 H
# DIMM DDR4 16GB
args @ {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/ksevelyar.nix
    ../users/kavarkon.nix
    ../users/root.nix

    ../hardware/efi.nix
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
    ../packages/neovim.nix
    ../packages/pass.nix

    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/wayland/hyprland.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix
  ];

  systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];

  networking.hostName = "tv";
  networking.interfaces.enp2s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  # http://localhost:8384/
  services = {
    syncthing = {
      enable = true;
      user = "kavarkon";
      dataDir = "/home/kavarkon/syncthing"; # Default folder for new synced folders
      configDir = "/home/kavarkon/.config/syncthing";
    };
  };

  home-manager.users.kavarkon = {
    home.pointerCursor = {
      size = 64;
    };

    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/hk47/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/hk47/hypr/hyprland.conf;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/hk47/waybar/waybar-bottom.json;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/hk47/waybar/waybar-top.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/hk47/waybar/waybar.css;
  };

  environment.sessionVariables = {
    XCURSOR_SIZE = "64";
  };
  home-manager.users.ksevelyar = {
    home.pointerCursor = {
      size = 64;
    };

    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/hk47/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/hk47/hypr/hyprland.conf;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/hk47/waybar/waybar-bottom.json;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/hk47/waybar/waybar-top.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/hk47/waybar/waybar.css;
  };
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u32n.psf.gz";

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.extraModulePackages = [config.boot.kernelPackages.rtl88x2bu]; # tp-link archer t3u
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

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };
}
