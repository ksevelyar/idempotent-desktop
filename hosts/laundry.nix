{ config, lib, pkgs, vars, ... }:
{
  vars.battery = "BATT";

  imports =
    [
      ../users/shared.nix
      ../users/ksevelyar.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/amd-gpu.nix
      ../hardware/amd-cpu.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix
      ../hardware/power-management.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/fonts.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix

      ../boot/efi.nix
      ../boot/multiboot.nix
      # ../boot/plymouth.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/x-common.nix
      ../packages/dev.nix
      ../packages/3d-print.nix
      ../packages/electronics.nix
      ../packages/firefox.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix

      # ../services/flatpak.nix
      # ../services/mongodb.nix
      ../services/journald.nix
      ../services/postgresql.nix
      ../services/redis.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/xmonad.nix
      ../services/x/redshift.nix

      # ../services/net/i2pd.nix
      # ../services/net/fail2ban.nix
      ../services/net/firewall-desktop.nix
      # ../services/net/nginx.nix # id-doc
      ../services/net/openvpn.nix
      ../services/net/sshd.nix
      ../services/net/tor.nix
      ../services/net/wireguard.nix

      # ../services/vm/hypervisor.nix
      # ../services/vm/docker.nix
    ];


  home-manager = {
    users.ksevelyar = {
      home.file.".config/polybar/launch.sh".source = ../users/shared/.config/polybar/launch-laptop.sh;

      home.file.".config/alacritty/alacritty.yml".source = ../users/ksevelyar/.config/alacritty-laptop/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../users/ksevelyar/.config/alacritty-laptop/alacritty-scratchpad.yml;
    };
  };
  # systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        accelProfile = "adaptive"; # flat profile for touchpads
        naturalScrolling = false;
        accelSpeed = "0.2";
        disableWhileTyping = true;
        clickMethod = "buttonareas";
      };
    };
  };


  # boot.kernelPackages = pkgs.linuxPackages_latest; # fix Cambridge Silicon Radio wi-fi dongles
  boot.loader.grub.splashImage = ../assets/displayManager.png;
  boot.loader.grub.splashMode = "stretch";

  # boot
  boot.blacklistedKernelModules = [];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # net
  networking.hostName = "laundry";
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.useDHCP = false;
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.46" ];
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # hardware
  # RedmiBook 14 II R7 16/512Gb Silver
  # AMD Ryzen 7 4700U
  # 16Gb DDR4
  # AMD Radeon RX Vega 7
  # SSD 512Gb
  # IPS 1920x1080
  hardware = {
    # pulseaudio.configFile = ../users/shared/disable-hdmi.pa;
  };

  # fs
  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/044a758f-4252-4e42-b68c-a87d2345dc4c nixos
  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  # sudo fatlabel /dev/disk/by-uuid/3A05-EA05 boot
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
  };
}
