{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.09";

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/ksevelyar.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/nvidia.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/debug.nix
      ../sys/fonts.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/vars.nix

      ../boot/efi.nix
      ../boot/multiboot.nix
      ../boot/plymouth.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/3d-print.nix
      ../packages/electronics.nix
      ../packages/firefox-without-tabs.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      ../packages/x-common.nix

      # ../services/flatpak.nix
      # ../services/mongodb.nix
      ../services/journald.nix
      ../services/postgresql.nix
      ../services/redis.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/xmonad.nix

      # ../services/net/i2pd.nix
      ../services/net/fail2ban.nix
      ../services/net/firewall-desktop.nix
      ../services/net/nginx.nix # id-doc
      ../services/net/openvpn.nix
      ../services/net/sshd.nix
      ../services/net/tor.nix
      ../services/net/wireguard.nix

      ../services/vm/hypervisor.nix
      # ../services/vm/docker.nix
    ];

  # build arm from x64
  # set rpi_img (sudo nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=/etc/nixos/live-usb/rpi.nix --no-out-link --argstr system aarch64-linux)
  # du -h $rpi_img
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nixpkgs.config.allowUnsupportedSystem = true;

  # boot.kernelPackages = pkgs.linuxPackages_latest; # fix Cambridge Silicon Radio wi-fi dongles
  boot.loader.grub.splashImage = ../assets/displayManager.png;

  # boot
  boot.blacklistedKernelModules = [];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = false; # run nmtui for wi-fi

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.47" ];
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "77.37.166.17:51820";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # hardware
  ## i5-9400F
  ## PRIME B360M-K
  ## RTX 2060
  ## DIMM DDR4 2133MHz 8GBx2
  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.configFile = ../users/shared/disable-hdmi.pa;
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

  # sudo e2label /dev/disk/by-uuid/bd7a95b1-0a44-4477-8616-177b95561ad1 storage
  fileSystems."/storage" =
    {
      device = "/dev/disk/by-label/storage";
      fsType = "ext4";
      options = [ "noatime" ];
    };

  fileSystems."/skynet" = {
    device = "192.168.0.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
  };
}
