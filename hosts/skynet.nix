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
      ../modules/sys/tty.nix
      ../modules/sys/headless.nix
      # ../modules/sys/debug.nix

      ../modules/boot/bios.nix
      # ../modules/boot/multiboot.nix

      ../modules/services/common.nix
      ../modules/services/nginx.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/nvim.nix
      ../modules/packages/tmux.nix

      ../modules/hardware/ssd.nix

      ../modules/net/router.nix
      ../modules/net/wireguard.nix
      ../modules/net/nfs.nix

      ../users/ksevelyar-headless.nix
    ];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "skynet";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkForce false;

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
