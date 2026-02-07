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

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/x-common.nix
    ../packages/3d-print.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/spotify.nix
    ../packages/electronics.nix

    ../services/auto-mount.nix
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
    ../services/net/wireguard.nix
    ../services/net/avahi.nix

    ../services/vm/docker.nix
    ../services/vm/hypervisor.nix
  ];

  environment.systemPackages = with pkgs; [
    aria2
    yazi
  ];

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.xray-json.path;
  };

  services.zapret = {
    enable = true;
    whitelist = [
      "youtube.com"
      "googlevideo.com"
      "ytimg.com"
      "youtu.be"
      "discord.com"
      "discord-attachments-uploads-prd.storage.googleapis.com"
      "googleapis.com"
    ];
    params = [
      "--dpi-desync=fake"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-fake-tls=0x00000000"
      "--dpi-desync-fake-tls=!"
      "--dpi-desync-fake-tls-mod=rnd,rndsni,dupsid"
    ];
  };

  services.earlyoom.enable = true;
  boot.kernelParams = [
    "amdgpu.cwsr_enable=0"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.dpi = 120;
  # http://localhost:2017/
  services.v2raya.enable = true;

  home-manager.users.ksevelyar = {
    home.file.".config/polybar/config.ini".source = ../users/ksevelyar/hk47/polybar.ini;
    home.file.".config/leftwm/themes/current/up".source = ../users/ksevelyar/hk47/leftwm/up;
  };

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp7s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  # http://localhost:8384/
  services = {
    syncthing = {
      enable = true;
      user = "ksevelyar";
      dataDir = "/home/ksevelyar/syncthing";
      configDir = "/home/ksevelyar/.config/syncthing";
    };
  };

  services.udev.extraRules = ''
    # microbit v2
    ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="660", GROUP="dialout"

    # STMicroelectronics ST-LINK/V2
    ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="660", GROUP="dialout"
  '';

  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/akira.png;
  boot.loader.grub.memtest86.enable = true;
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
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
