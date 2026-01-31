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
    ../sys/cache.nix

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../packages/x-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/avahi.nix
  ];

  environment.systemPackages = with pkgs; [
    foliate
    obsidian
    gnumake
    lutris
    spaceFM
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

  home-manager.users.kh = {
    home.file.".config/polybar/config".source = lib.mkForce ../users/kh/polybar/polybar-catch22;
    home.file.".config/leftwm/config.ron".source = ../users/kh/catch-22/leftwm.ron;
    home.file.".config/alacritty/alacritty.toml".source = ../users/kh/catch-22/alacritty.toml;
    home.file.".config/alacritty/alacritty-scratchpad.toml".source = ../users/kh/catch-22/alacritty-scratchpad.toml;
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
