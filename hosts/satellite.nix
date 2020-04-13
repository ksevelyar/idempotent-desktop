{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.useDHCP = false;
  networking.interfaces.eno0.useDHCP = true;
  networking.hostName = "satellite";
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4aaad1a6-008e-422b-aa45-0c2cbb0e8f27";
      fsType = "ext4";
    };

  swapDevices = [];
  services.xserver.videoDrivers = [ "intel" ];

  nix.maxJobs = lib.mkDefault 3;

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

}
