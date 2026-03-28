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
    ../hardware/disable-sleep.nix

    ../sys/aliases.nix
    ../sys/fonts.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix

    ../packages/wayland-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/3d-print.nix
    ../packages/games.nix
    ../packages/games-retro.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/spotify.nix
    ../packages/electronics.nix

    ../services/wayland/hyprland.nix
    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix
    ../services/net/network-manager.nix
    ../services/net/dns.nix
  ];

  environment.systemPackages = with pkgs; [
    aria2
  ];

  # NOTE: bpi m2 zero
  boot.binfmt.emulatedSystems = ["armv7l-linux"];
  nix.settings.system-features = ["gccarch-armv7-a"];

  home-manager.users.ksevelyar = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/hk47/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/hk47/hypr/hyprland.conf;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/hk47/waybar/waybar-bottom.json;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/hk47/waybar/waybar-top.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/hk47/waybar/waybar.css;
  };

  # net
  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.ksevelyar-xray-json.path;
  };

  networking.hostName = "hk47";
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp7s0.useDHCP = true;
  networking.useDHCP = false;

  networking.networkmanager.ensureProfiles.profiles = {
    wifi1.connection.autoconnect-priority = 2;
    wifi2.connection.autoconnect-priority = 1;
  };

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

  home-manager.users.ksevelyar = {
    services.syncthing = {
      enable = true;
      guiAddress = "127.0.0.1:7777";

      settings = {
        devices = {
          phone = {
            id = "NLZI2AJ-3TAXAME-VXMNYUD-LEEDHMT-T2DT5UD-JS63KY5-H3NXS2N-Q4OQXQK";
            name = "phone";
          };
          tablet = {
            id = "Q4ZLGMS-VDQ3OT7-5JGCRMY-YVCRRWS-XMMWK4K-4ID2PWW-SRO3QRK-HA6WXQJ";
            name = "tablet";
          };
          laundry = {
            id = "DVNSUNC-HMHKNMY-MASHHYU-7LYBLHP-4KPS2BJ-EA7BLEV-CAXKMEK-3RSD2QA";
            name = "laundry";
          };
        };

        folders = {
          sync = {
            path = "~/sync";
            id = "sync";
            label = "sync";
            type = "sendreceive";
            devices = ["phone" "tablet" "laundry"];
          };
        };
      };
    };
  };

  boot.kernelParams = [
    # NOTE: fix ollama crashes
    "amdgpu.cwsr_enable=0"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
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
