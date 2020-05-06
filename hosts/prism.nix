{ config, lib, pkgs, ... }:
{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/absolutely-proprietary.nix
      ../modules/aliases.nix
      ../modules/scripts.nix
      ../modules/boot/bios.nix
      ../modules/boot/multiboot.nix
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

      # ../modules/vm/hypervisor.nix

      ../modules/laptop.nix
      ../users/obstinatekate.nix
    ];

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.5" ];
      privateKeyFile = "/home/obstinatekate/wireguard-keys/private";

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
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.hostName = "prism"; # Define your hostname.

  services.xserver.videoDrivers = [ "ati-drivers" ];
  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.plymouth.enable = false;

  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/32685a01-79cc-4ec0-9d6f-c8708c897a3b nixos
  fileSystems."/" =
    {
      # device = "/dev/disk/by-label/nixos";
      device = "/dev/disk/by-uuid/32685a01-79cc-4ec0-9d6f-c8708c897a3b";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };
}
