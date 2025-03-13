# 53013PEW, F12 for UEFI, F2 for quick boot
args @ {
  config,
  lib,
  pkgs,
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
    ../hardware/intel-gpu.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix
    (import ../hardware/power-management.nix {
      pkgs = pkgs;
      battery = "BAT1";
    })

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

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/databases/redis.nix
    ../services/x.nix
    ../services/x/redshift.nix
    ../services/x/picom.nix
    ../services/x/unclutter.nix

    ../services/net/firewall-desktop.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
  ];

  networking.hostName = "laundry";
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  home-manager.users.ksevelyar = {
    home.file.".config/leftwm/config.ron".source = ../users/ksevelyar/laundry/leftwm.ron;
    home.file.".config/polybar/config.ini".source = ../users/ksevelyar/laundry/polybar.ini;
    home.file.".config/alacritty/alacritty.toml".source = ../users/ksevelyar/laundry/alacritty.toml;
    home.file.".config/alacritty/alacritty-scratchpad.toml".source = ../users/ksevelyar/laundry/alacritty-scratchpad.toml;
  };

  services = {
    syncthing = {
      enable = true;
      user = "ksevelyar";
      dataDir = "/home/ksevelyar/syncthing"; # Default folder for new synced folders
      configDir = "/home/ksevelyar/.config/syncthing";
    };
  };

  environment.systemPackages = with pkgs; [
    vmpk
    qsynth
    qjackctl
  ];
  services.xserver.dpi = 130;

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.configurationLimit = 3;
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  services = {
    libinput = {
      enable = true;
      touchpad = {
        accelProfile = "adaptive"; # flat profile for touchpads
        naturalScrolling = false;
        accelSpeed = "0.3";
        disableWhileTyping = true;
        scrollMethod = "twofinger";
      };
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
    device = "/dev/disk/by-label/SYSTEM";
    fsType = "vfat";
    options = ["noatime" "nodiratime"];
  };
}
