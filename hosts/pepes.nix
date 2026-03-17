# RedmiBook 14 II TM1951-28953 (F12 for boot menu)
{
  config,
  lib,
  pkgs,
  ...
}:
let
  dsdtOverlay = pkgs.runCommand "dsdt-override" {} ''
    mkdir -p $out/kernel/firmware/acpi
    cp ${../users/kh/pepes/dsdt.aml} $out/kernel/firmware/acpi/DSDT.aml
    cd $out
    find kernel | ${pkgs.cpio}/bin/cpio -H newc --create > $out/dsdt.cpio
  '';
in
{
  imports = [
    ../users/kh.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/amd-gpu.nix
    ../hardware/amd-cpu.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix
    ../hardware/power-management.nix

    ../sys/aliases.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/fonts.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/wayland-common.nix
    ../packages/3d-print.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix

    ../services/wayland/hyprland.nix
    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
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
    mattermost
    asciinema
    gnumake

    lutris
    wineWowPackages.stable
  ];

  networking.hostName = "pepes";
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u32n.psf.gz";
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;

  home-manager.users.kh = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/laundry/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/laundry/hypr/hyprland.conf;
    home.file.".config/waybar/config".source = ../users/ksevelyar/laundry/waybar/waybar.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/laundry/waybar/waybar.css;

    home.file.".config/alacritty/alacritty.toml".source = ../users/kh/pepes/alacritty.toml;
  };

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";
  boot.loader.systemd-boot.configurationLimit = 2;

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "sd_mod"];
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.initrd.prepend = [ "${dsdtOverlay}/dsdt.cpio" ];
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
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
}
