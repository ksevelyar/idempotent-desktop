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
      ../modules/dev/packages.nix

      ../modules/common-packages.nix
      ../modules/ssd.nix
      ../modules/router.nix
      # ./modules/extra-packages.nix
      # ./modules/dev-packages.nix
      # ./modules/games.nix
      ../modules/services-headless.nix
      # ./modules/x.nix

      # ./modules/fonts.nix
      # ./modules/fonts-high-dpi.nix
      # ./modules/laptop.nix

      ../users/ksevelyar-headless.nix
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkDefault true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.useDHCP = false;
  networking.interfaces.eno0.useDHCP = true;
  networking.hostName = "satellite";

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
