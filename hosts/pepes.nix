{
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
    ../hardware/mouse.nix
    ../hardware/amd-gpu.nix
    ../hardware/amd-cpu.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix
    (import ../hardware/power-management.nix {
      pkgs = pkgs;
      battery = "BATT";
    })

    ../sys/aliases.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/fonts.nix
    ../sys/cache.nix

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/x.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/2d-graphics.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix
    ../packages/x-common.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    ../services/net/sshd.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/avahi.nix
  ];

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.xray-json.path;
  };

  environment.systemPackages = with pkgs; [
    foliate
    obsidian
    mattermost
    asciinema
    gnumake
  ];

  networking.hostName = "pepes";
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u24n.psf.gz";
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;

  home-manager.users.kh = {
    home.file.".config/leftwm/config.ron".source = ../users/kh/pepes/leftwm.ron;
    home.file.".config/polybar/config".source = ../users/kh/polybar/polybar-pepes;
    home.file.".config/alacritty/alacritty.toml".source = ../users/kh/pepes/alacritty.toml;
    home.file.".config/alacritty/alacritty-scratchpad.toml".source = ../users/kh/pepes/alacritty-scratchpad.toml;
  };

  services = {
    libinput = {
      enable = true;
      touchpad = {
        accelProfile = "adaptive"; # flat profile for touchpads
        naturalScrolling = false;
        accelSpeed = "0.2";
        disableWhileTyping = true;
        scrollMethod = "twofinger";
      };
    };
  };

  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashImage = lib.mkForce ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "sd_mod"];

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
