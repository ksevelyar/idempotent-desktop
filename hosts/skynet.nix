{ config, lib, pkgs, ... }:
{
  system.stateVersion = "9000";

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/ksevelyar.nix

      ../modules/sys/aliases.nix
      ../modules/sys/scripts.nix
      ../modules/sys/tty.nix
      ../modules/sys/nix.nix
      ../modules/sys/vars.nix

      ../modules/boot/bios.nix

      ../modules/services/common.nix
      # ../modules/services/mongodb.nix
      ../modules/services/murmur.nix
      # ../modules/services/xonotic-dedicated.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/nvim.nix
      ../modules/packages/tmux.nix

      ../modules/net/router.nix
      ../modules/net/nginx.nix
      ../modules/net/wireguard.nix
      ../modules/net/nfs.nix
      ../modules/net/sshd.nix
      # ../modules/net/minecraft.nix
    ];

  services.nginx = {
    virtualHosts."legacy-intelligence.life" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/legacy-intelligence/dist/";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "skynet";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkForce false;

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_1024x768.png;
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/44b4a02e-1993-4470-b345-b2ca5e3e5b42 nixos
  # sudo e2label /dev/sdb1 storage

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  # fileSystems."/storage" =
  #   {
  #     device = "/dev/disk/by-label/storage";
  #     fsType = "ext4";
  #   };
}
