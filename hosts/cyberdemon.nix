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
  boot.plymouth.enable = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/df8dcd09-38bd-4632-8041-8219ebdc5571";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/8CCE-4F4F";
      fsType = "vfat";
    };

  swapDevices = [];

  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp61s0.useDHCP = true;
  networking.hostName = "cyberdemon";

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  services.xserver.videoDrivers = [ "intel" ];
}
