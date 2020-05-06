{ config, lib, pkgs, ... }:
{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/absolutely-proprietary.nix
      ../modules/aliases.nix
      ../modules/scripts.nix
      ../modules/boot/efi.nix
      ../modules/services.nix

      ../modules/common-packages.nix
      ../modules/extra-packages.nix
      ../modules/dev-packages.nix
      ../modules/games.nix

      ../modules/x.nix
      ../modules/bluetooth.nix
      ../modules/sound.nix
      ../modules/firewall-desktop.nix
      ../modules/fonts.nix
      ../modules/wireguard.nix
      ../modules/ssd.nix

      ../modules/vm/hypervisor.nix

      # ../modules/laptop.nix
      ../users/ksevelyar.nix
    ];

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.47" ];
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

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

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia.modesetting.enable = true;
  };

  networking.hostName = "laundry";
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.plymouth.enable = false;

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

  services.nfs.server.enable = false;
  services.nfs.server.exports = ''
    /srv         192.168.0.1/24(ro,all_squash,insecure,fsid=0,crossmnt)
    /srv/storage 192.168.0.1/24(rw,nohide,all_squash,insecure)
    /srv/vvv     192.168.0.1/24(rw,nohide,all_squash,insecure)
  '';

  services.aria2 = {
    downloadDir = "/storage/tmp";
  };

  services.syncthing = {
    enable = false;
    user = "ksevelyar";
    dataDir = "/storage/syncthing";
    openDefaultPorts = true;
  };
}
