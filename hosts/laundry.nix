# 53013PEW, F12 for UEFI, F2 for quick boot
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
    ../hardware/multiboot.nix
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
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix

    ../services/wayland/hyprland.nix
    ../services/auto-mount.nix
    ../services/journald.nix
    ../services/databases/postgresql.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix
    ../services/net/wireguard.nix
    ../services/net/network-manager.nix

    ../services/vm/docker.nix
  ];

  networking.hostName = "laundry";
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  networking.networkmanager.ensureProfiles.profiles = {
    wifi1.connection.autoconnect-priority = 2;
    wifi2.connection.autoconnect-priority = 1;
  };

  networking.firewall.trustedInterfaces = [ "skynet" ];
  networking.wireguard.interfaces.skynet = {
    ips = ["10.10.10.3/24"];
    privateKeyFile = config.age.secrets.wg-laundry.path;
    peers = [
      {
        publicKey = "U5Yho/fX8/b8ZepkpB16ye0JOweRbMO6CHmvu/+v7Gk=";
        endpoint = "212.109.193.139:444";
        allowedIPs = ["10.10.10.0/24"];
        persistentKeepalive = 25;
      }
    ];
  };

  home-manager.users.ksevelyar = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/laundry/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/laundry/hypr/hyprland.conf;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/laundry/waybar/waybar-top.json;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/laundry/waybar/waybar-bottom.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/laundry/waybar/waybar.css;

    home.file.".config/alacritty/alacritty.toml".source = ../users/ksevelyar/laundry/alacritty/alacritty.toml;
  };

  home-manager.users.kavarkon = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/laundry/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/laundry/hypr/hyprland.conf;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/laundry/waybar/waybar-top.json;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/laundry/waybar/waybar-bottom.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/laundry/waybar/waybar.css;

    home.file.".config/alacritty/alacritty.toml".source = ../users/ksevelyar/laundry/alacritty/alacritty.toml;
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
          hk47 = {
            id = "VP4EUM6-QW5JKXZ-HQFJKE3-FPLE4TV-5ZJHNRY-XVHAZAM-KSW5CHU-XBQAMQD";
            name = "hk47";
          };
        };

        folders = {
          sync = {
            path = "~/sync";
            id = "sync";
            label = "sync";
            type = "sendreceive";
            devices = ["phone" "tablet" "hk47"];
          };
        };
      };
    };
  };

  services.zapret = {
    enable = true;
    configureFirewall = true;

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

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.ksevelyar-xray-json.path;
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
    curlie

    vmpk
    qsynth
    qjackctl
  ];

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u32n.psf.gz";
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.configurationLimit = 3;
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = false;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/SYSTEM";
    fsType = "vfat";
  };
}
