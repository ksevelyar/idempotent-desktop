# hardware
## MSI PRO B650M-B (F11 for boot menu)
## AMD Ryzen 7 7700
## RX 9060 XT 16GB
## DGMAD55600016S DDR5 5600MHz 16GBx2
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
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/amd-cpu.nix
    ../hardware/amd-gpu.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix

    ../sys/aliases.nix
    ../sys/fonts.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/cache.nix

    ../packages/wayland-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/3d-print.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/spotify.nix
    ../packages/electronics.nix

    ../services/wayland/hyprland.nix
    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix
    # ../services/databases/redis.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix

    # ../services/vm/hypervisor.nix
  ];

  environment.systemPackages = with pkgs; [
    aria2
    yazi
  ];

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.ksevelyar-xray-json.path;
  };

  services.earlyoom.enable = true;
  boot.kernelParams = [
    "amdgpu.cwsr_enable=0"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  home-manager.users.ksevelyar = {
    home.file.".config/waybar/config".source = ../users/ksevelyar/hk47/waybar/waybar.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/hk47/waybar/waybar.css;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/hk47/hypr/hyprland.conf;
    home.file.".config/hypr/hyprpaper.conf".source = ../users/ksevelyar/hk47/hypr/hyprpaper.conf;
  };

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp7s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  networking.wireguard.interfaces.skynet = {
    ips = ["10.10.10.2/24"];
    privateKeyFile = config.age.secrets.wg-hk47.path;
    peers = [
      {
        publicKey = "U5Yho/fX8/b8ZepkpB16ye0JOweRbMO6CHmvu/+v7Gk=";
        endpoint = "212.109.193.139:444";
        allowedIPs = ["10.10.10.0/24"];
        persistentKeepalive = 10;
      }
    ];
  };

  services.zapret = {
    enable = true;
    whitelist = [
      "youtube.com"
      "googlevideo.com"
      "ytimg.com"
      "youtu.be"
    ];
    params = [
      "--dpi-desync=fake"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-fake-tls=0x00000000"
      "--dpi-desync-fake-tls=!"
      "--dpi-desync-fake-tls-mod=rnd,rndsni,dupsid"
    ];
  };

  # http://localhost:8384/
  services = {
    syncthing = {
      enable = true;
      user = "ksevelyar";
      dataDir = "/home/ksevelyar/syncthing";
      configDir = "/home/ksevelyar/.config/syncthing";
    };
  };

  boot.loader.grub.memtest86.enable = true;
  boot.loader.grub.splashImage = ../assets/wallpapers/johnny.jpg;
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
