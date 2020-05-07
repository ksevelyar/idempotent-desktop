{ config, lib, pkgs, ... }:
{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/sys/aliases.nix
      ../modules/sys/scripts.nix
      # ../modules/sys/debug.nix

      ../modules/boot/efi.nix
      # ../modules/boot/multiboot.nix

      ../modules/services/common.nix
      ../modules/services/x.nix

      ../modules/x/xmonad.nix
      ../modules/x/fonts.nix
      ../modules/packages/x-common.nix
      ../modules/packages/x-extra.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix
      ../modules/packages/games.nix
      ../modules/packages/nvim.nix
      ../modules/packages/tmux.nix

      ../modules/hardware/bluetooth.nix
      ../modules/hardware/sound.nix
      ../modules/hardware/ssd.nix

      ../modules/net/firewall-desktop.nix
      ../modules/net/wireguard.nix

      ../modules/vm/hypervisor.nix

      ../users/ksevelyar.nix
    ];

  # boot
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.plymouth.enable = false;
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia.modesetting.enable = true;
  };


  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/044a758f-4252-4e42-b68c-a87d2345dc4c nixos
  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  # sudo fatlabel /dev/disk/by-uuid/3A05-EA05
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
      options = [ "noatime" "nodiratime" ];
    };

  # fileSystems."/mnt/skynet" = {
  #   device = "192.168.0.1:/export";
  #   fsType = "nfs";
  # };

  # services.nfs.server.exports = ''
  #   /srv         192.168.0.1/24(ro,all_squash,insecure,fsid=0,crossmnt)
  #   /srv/storage 192.168.0.1/24(rw,nohide,all_squash,insecure)
  #   /srv/vvv     192.168.0.1/24(rw,nohide,all_squash,insecure)
  # '';
}
