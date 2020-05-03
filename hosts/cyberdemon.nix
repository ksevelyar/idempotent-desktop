{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/absolute-proprietary.nix
      ../modules/aliases.nix
      ../modules/scripts.nix
      ../modules/boot.nix
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
      ../modules/nebula.nix
      ../modules/ssd.nix

      ../modules/vm/hypervisor.nix

      ../modules/laptop.nix
      ../users/manya.nix
    ];

  environment.etc."/nebula/node.crt".source = /storage/nebula/cyberdemon.crt;
  environment.etc."/nebula/node.key".source = /storage/nebula/cyberdemon.key;
  environment.etc."/nebula/node.yml".source = /storage/nebula/node.yml;
  environment.etc."/nebula/ca.crt".source = /storage/nebula/ca.crt;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
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
