{ config, lib, pkgs, ... }:
{
  imports = [
    ../users/kh.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/amd-gpu.nix
    ../hardware/amd-cpu.nix
    ../hardware/pulseaudio.nix
    ../hardware/ssd.nix
    (import ../hardware/power-management.nix ({ pkgs = pkgs; battery = "BATT"; }))

    # ../sys/debug.nix
    ../sys/aliases.nix
    ../sys/nix.nix
    ../sys/scripts.nix
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

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/dev.nix
    ../packages/2d-graphics.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/tmux.nix
    ../packages/x-common.nix
    # ../packages/freelance.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    ../services/net/sshd.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
    ../services/net/avahi.nix
    ../services/mpd.nix

    # ../services/vm/hypervisor.nix
  ];

  networking.hostName = "pepes";
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u24n.psf.gz";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.11" ];
      privateKeyFile = "/home/kh/.secrets/wireguard/private";
      peers = [{
        publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
        allowedIPs = [ "192.168.42.0/24" ];
        endpoint = "95.165.99.133:51821";
        persistentKeepalive = 25;
      }];
    };
  };

  # vpn
  services.openvpn.servers = {
    uk-shark.autoStart = true;
    de-shark.autoStart = false;
    fr-shark.autoStart = false;
    us-proton.autoStart = false;
  };

  home-manager.users.kh = {
      home.file.".config/alacritty/alacritty.yml".source = ../users/kh/alacritty-laptop/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../users/kh/alacritty-laptop/alacritty-scratchpad.yml;
  };

  services.xserver = {
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
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];

  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  # fs
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "noatime" "nodiratime" ]; # ssd
  };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=300" ];
  };
}
