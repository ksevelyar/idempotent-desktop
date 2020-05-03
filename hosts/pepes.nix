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
      ../users/kh.nix
    ];

  environment.etc."/nebula/node.crt".source = /storage/nebula/pepes.crt;
  environment.etc."/nebula/node.key".source = /storage/nebula/pepes.key;
  environment.etc."/nebula/node.yml".source = /storage/nebula/node.yml;
  environment.etc."/nebula/ca.crt".source = /storage/nebula/ca.crt;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/2aeb21b3-e390-4f10-b163-7cf8615dc3bc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F25E-EE97";
      fsType = "vfat";
    };

  swapDevices = [];

  nix.maxJobs = lib.mkDefault 6;

  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;

  networking.hostName = "pepes";

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
  services.xserver.videoDrivers = [ "intel" ];

  console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  # services.xserver.dpi = 180;
  # environment.variables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };
}
