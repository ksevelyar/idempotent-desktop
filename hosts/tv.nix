args@{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
    ../hardware/intel-gpu.nix
    ../hardware/pulseaudio.nix
    ../hardware/ssd.nix

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
    ../packages/dev.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix

    ../services/mpd.nix
    ../services/journald.nix
    ../services/x.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix
    ../services/x/random-wallpaper.nix

    ../services/net/firewall-desktop.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix
  ];

  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];

  networking.hostName = "tv";
  networking.interfaces.eno1.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.42" ];
      privateKeyFile = "/home/ksevelyar/.secrets/wireguard/private";
      peers = [{
        publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
        allowedIPs = [ "192.168.42.0/24" ];
        endpoint = "95.165.99.133:51821";
        # Send keepalives every 25 seconds. Important to keep NAT tables alive.
        persistentKeepalive = 25;
      }];
    };
  };

  home-manager.users.ksevelyar = {
    home.pointerCursor = {
      x11.enable = true;
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 64;
    };

    home.file.".config/leftwm/config.toml".source = ../users/ksevelyar/leftwm-tv/config.toml;
    home.file.".config/leftwm/themes/current/theme.toml".source = ../users/ksevelyar/leftwm-tv/theme.toml;

    home.file.".config/polybar/config".source = ../users/shared/polybar/config-big;
    home.file.".config/alacritty/alacritty.yml".source = ../users/ksevelyar/alacritty-tv/alacritty.yml;
    home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../users/ksevelyar/alacritty-tv/alacritty-scratchpad.yml;

    home.file.".config/dunst/dunstrc".source = ../users/shared/dunst/dunstrc-big;
  };
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u24n.psf.gz";
  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';

  hardware = {
    pulseaudio = {
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
  };
  environment.variables = {
    GDK_SCALE = "2";
  };

  # N5105 H
  # DIMM DDR4 16GB
  services.xserver.displayManager.lightdm.background = ../assets/wallpapers/d-sparil.png;
  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ]; # tp-link archer t3u
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "noatime" "nodiratime" ];
  };
}
