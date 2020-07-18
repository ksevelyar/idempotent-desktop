{ config, lib, pkgs, ... }:
{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?


  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/manya.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/vars.nix
      ../sys/fonts.nix

      ../boot/efi.nix
      ../boot/multiboot.nix

      ../services/journald.nix
      ../services/x.nix
      ../services/postgresql.nix

      ../services/x/xmonad.nix
      ../packages/x-common.nix
      # ../packages/x-extra.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/tmux.nix

      ../hardware/power-management.nix
      ../hardware/bluetooth.nix
      ../hardware/sound.nix
      ../hardware/mouse.nix
      ../hardware/ssd.nix

      ../services/net/firewall-desktop.nix
      ../services/net/fail2ban.nix
      ../services/net/wireguard.nix
      ../services/net/i2pd.nix
      ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/nginx.nix
      ../services/net/openvpn.nix

      ../services/vm/hypervisor.nix
      # ../services/vm/docker.nix
    ];

  boot.cleanTmpDir = lib.mkDefault true;
  boot.tmpOnTmpfs = lib.mkDefault true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.plymouth.enable = true;

  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.hostName = "cyberdemon";
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp61s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.4" ];
      privateKeyFile = "/home/manya/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          # Set this to the server IP and port.
          endpoint = "77.37.166.17:51820";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/df8dcd09-38bd-4632-8041-8219ebdc5571";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/8CCE-4F4F";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  swapDevices = [];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
  services.xserver.videoDrivers = [ "intel" ];
}
