{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../users/kh.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/fonts.nix

      ../boot/efi.nix
      ../boot/multiboot.nix

      ../services/journald.nix
      ../services/postgresql.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/redshift.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/3d-print.nix
      ../packages/electronics.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      ../packages/x-common.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/amd-gpu.nix
      ../hardware/amd-cpu.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix
      (import ../hardware/power-management.nix ({ pkgs = pkgs; battery = "BATT"; }))

      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      # ../services/net/nginx.nix

      # ../services/vm/hypervisor.nix
    ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  home-manager = {
    users.kh = {
      home.file.".config/polybar/launch.sh".source = ../users/shared/.config/polybar/launch-laptop.sh;

      home.file.".config/alacritty/alacritty.yml".source = ../users/ksevelyar/.config/alacritty-laptop/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../users/ksevelyar/.config/alacritty-laptop/alacritty-scratchpad.yml;
    };
  };

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

  networking.hostName = "pepes";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.11" ];
      privateKeyFile = "/home/kh/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [];

  # fs
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

  swapDevices = [];
}
