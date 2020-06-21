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

      ../modules/sys/aliases.nix
      # ../modules/sys/debug.nix
      ../modules/sys/nix.nix
      ../modules/sys/scripts.nix
      ../modules/sys/sysctl.nix
      ../modules/sys/tty.nix
      ../modules/sys/vars.nix

      ../modules/boot/efi.nix
      ../modules/boot/multiboot.nix

      ../modules/services/common.nix
      ../modules/services/x.nix
      ../modules/services/postgresql.nix

      ../modules/x/xmonad.nix
      ../modules/x/fonts.nix
      ../modules/packages/x-common.nix
      # ../modules/packages/x-extra.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix
      ../modules/packages/games.nix
      ../modules/packages/nvim.nix
      ../modules/packages/tmux.nix

      ../modules/hardware/power-management.nix
      ../modules/hardware/bluetooth.nix
      ../modules/hardware/sound.nix
      ../modules/hardware/ssd.nix

      ../modules/net/firewall-desktop.nix
      ../modules/net/wireguard.nix
      ../modules/net/i2pd.nix
      ../modules/net/tor.nix
      ../modules/net/sshd.nix

      ../modules/vm/hypervisor.nix
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
