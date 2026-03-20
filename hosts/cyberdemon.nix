{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/manya.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/power-management.nix
    ../hardware/bluetooth.nix
    ../hardware/pipewire.nix
    ../hardware/mouse.nix
    ../hardware/ssd.nix
    ../hardware/intel-cpu.nix
    ../hardware/intel-gpu.nix

    ../sys/aliases.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/fonts.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/wayland-common.nix

    ../services/journald.nix
    ../services/wayland/hyprland.nix
    ../services/databases/postgresql.nix
    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix
    ../services/net/sshd.nix
  ];

  home-manager.users.manya = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/laundry/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/laundry/hypr/hyprland.conf;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/laundry/waybar/waybar-top.json;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/laundry/waybar/waybar-bottom.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/laundry/waybar/waybar.css;

    home.file.".config/alacritty/alacritty.toml".source = ../users/ksevelyar/laundry/alacritty/alacritty.toml;
  };

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.plymouth.enable = true;

  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.hostName = "cyberdemon";
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp61s0.useDHCP = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/df8dcd09-38bd-4632-8041-8219ebdc5571";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8CCE-4F4F";
    fsType = "vfat";
  };
}
