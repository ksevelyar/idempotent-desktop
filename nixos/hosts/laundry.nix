{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/044a758f-4252-4e42-b68c-a87d2345dc4c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/3A05-EA05";
      fsType = "vfat";
    };

  fileSystems."/storage" =
    {
      device = "/dev/disk/by-uuid/bd7a95b1-0a44-4477-8616-177b95561ad1";
      fsType = "ext4";
    };

  swapDevices = [];

  nix.maxJobs = lib.mkDefault 6;

  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.hostName = "laundry";

  hardware = {
    cpu.intel.updateMicrocode = true;
    # nvidia.modesetting.enable = true;
  };

}
