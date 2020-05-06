{ config, lib, pkgs, ... }:
{
  boot.cleanTmpDir = lib.mkDefault true;
  boot.tmpOnTmpfs = lib.mkDefault true;

  nix = {
    useSandbox = true;
    maxJobs = lib.mkDefault 2;
    extraOptions = ''
      connect-timeout = 10 
      http-connections = 4
    '';
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?


  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/aliases.nix
      # FIXME: find replacement for memtest
      ../modules/absolutely-proprietary.nix
      ../modules/scripts.nix
      ../modules/boot/bios.nix

      ../modules/dev/nvim.nix
      ../modules/common-packages.nix
      ../modules/ssd.nix
      ../modules/router.nix
      # ./modules/extra-packages.nix
      # ../modules/dev/packages.nix
      # ./modules/games.nix
      ../modules/services-headless.nix
      # ../modules/services/nfs.nix
      # ./modules/x.nix

      # ./modules/fonts.nix
      # ./modules/fonts-high-dpi.nix
      # ./modules/laptop.nix

      ../users/ksevelyar-headless.nix
    ];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "skynet";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkForce false;

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
