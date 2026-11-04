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

    ../packages/wayland-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/3d-print.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/spotify.nix
    ../packages/electronics.nix
    ../packages/inference.nix
    ../packages/office.nix

    ../services/wayland/hyprland.nix
    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/databases/redis.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix
    ../services/net/network-manager.nix
    # ../services/net/dns.nix

    ../services/vm/docker.nix
  ];
  environment.systemPackages = with pkgs; [
    ffmpeg
    aria2
    android-tools
  ];

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
  networking.interfaces.wlp21s0f4u1.useDHCP = true;
  networking.useDHCP = false;

  # TODO: move 22000 to syncthing module
  networking.firewall = {
    allowedTCPPorts = [3003 22000];
    allowedUDPPorts = [22000];
  };

  networking.networkmanager.ensureProfiles.profiles = {
    wifi1.connection.autoconnect-priority = 2;
    wifi2.connection.autoconnect-priority = 1;
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
        urAccepted = -1;
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

          phone-camera = {
            path = "~/phone-camera";
            id = "phone-camera";
            label = "phone-camera";
            type = "sendreceive";
            devices = ["phone" "laundry"];
          };
        };
      };
    };
  };

  # NOTE: bpi m2 zero, rpi zero 2w
  boot.binfmt.emulatedSystems = ["armv7l-linux" "aarch64-linux"];
  nix.settings.system-features = ["gccarch-armv7-a"];

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

  systemd.tmpfiles.rules = [
    "d /data 0755 ksevelyar root - -"
  ];

  home-manager.users.ksevelyar.games = {
    atomic-heart = {
      type = "wine";
      gameDirectory = "/data/games/atomic-heart";
      runtime = "proton-ge-11-1";
      executable = "AtomicHeart.exe";
      installation = {
        type = "inno-setup";
        source = "/data/games/Atomic Heart/Setup.exe";
      };
    };

    clive-barkers-hellraiser-revival = {
      type = "wine";
      runtime = "proton-ge-11-1";
      executable = "Hellraiser.exe";
      installation = {
        type = "portable";
      };
      gameDirectory = "/home/ksevelyar/games/Clive.Barkers.Hellraiser.Revival";
    };

    hyperviolent = {
      type = "wine";
      gameDirectory = "/data/games/hyperviolent";
      runtime = "proton-ge-11-1";
      executable = "HYPERVIOLENT.exe";
      installation = {
        type = "inno-setup";
        source = "/data/games/setup_hyperviolent_1.0.0.2a_(64bit)_(85303).exe";
      };
    };

    indiana-jones-and-the-great-circle = {
      type = "wine";
      runtime = "proton-ge-11-1";
      executable = "TheGreatCircle.exe";
      installation = {
        type = "portable";
      };
      gameDirectory = "/data/games/Indiana.Jones.and.the.Great.Circle.Premium.Edition";
    };

    ghosts-n-goblins = {
      type = "retroarch";
      platform = "nes";
      rom = "/data/games/rom/nes/Ghosts n Goblins.nes";
    };
    gradius = {
      type = "retroarch";
      platform = "nes";
      rom = "/data/games/rom/nes/Gradius.nes";
    };
    legend-of-zelda = {
      type = "retroarch";
      platform = "nes";
      rom = "/data/games/rom/nes/Legend of Zelda, The.nes";
    };
    super-mario-bros = {
      type = "retroarch";
      platform = "nes";
      rom = "/data/games/rom/nes/Super Mario Bros.nes";
    };

    legend-of-zelda-a-link-to-the-past = {
      type = "retroarch";
      platform = "snes";
      rom = "/data/games/rom/snes/Legend of Zelda, The - A Link to the Past.smc";
    };
    mega-man-x = {
      type = "retroarch";
      platform = "snes";
      rom = "/data/games/rom/snes/Mega Man X.smc";
    };
    super-metroid = {
      type = "retroarch";
      platform = "snes";
      rom = "/data/games/rom/snes/Super Metroid.smc";
    };

    mortal-kombat = {
      type = "retroarch";
      platform = "genesis";
      rom = "/data/games/rom/genesis/Mortal Kombat.bin";
    };
    streets-of-rage = {
      type = "retroarch";
      platform = "genesis";
      rom = "/data/games/rom/genesis/Streets of Rage.bin";
    };
  };
}
