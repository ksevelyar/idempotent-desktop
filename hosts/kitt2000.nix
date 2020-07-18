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
      ../sys/aliases.nix
      ../sys/scripts.nix
      ../sys/vars.nix
      # ../sys/debug.nix

      ../boot/bios.nix
      # ../boot/multiboot.nix

      ../services/common.nix
      ../services/nginx.nix
      # ../services/nfs.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/nvim.nix
      ../packages/tmux.nix

      ../hardware/bluetooth.nix

      ../services/net/wireguard.nix

      ../users/shared.nix
      ../users/ksevelyar.nix
    ];

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.hostName = "kitt2000";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.interfaces.eno0.useDHCP = true;

  # sudo e2label /dev/disk/by-uuid/44b4a02e-1993-4470-b345-b2ca5e3e5b42 nixos
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4aaad1a6-008e-422b-aa45-0c2cbb0e8f27";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  swapDevices = [];
  services.xserver.videoDrivers = [ "intel" ];
  hardware = {
    cpu.intel.updateMicrocode = true;
  };
}
