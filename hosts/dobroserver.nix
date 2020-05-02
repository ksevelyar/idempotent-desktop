{ config, lib, pkgs, ... }:
{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ./modules/aliases.nix
      ./modules/scripts.nix
      ./modules/boot-legacy.nix

      ./modules/common-packages.nix
      ./modules/ssd.nix
      ./modules/router.nix
      ./modules/nebula.nix
      # ./modules/extra-packages.nix
      # ./modules/dev-packages.nix
      # ./modules/games.nix
      # ./modules/services.nix
      # ./modules/x.nix

      # ./modules/fonts.nix
      # ./modules/fonts-high-dpi.nix
      # ./modules/laptop.nix

      ./users/ksevelyar-headless.nix
    ];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "dobroserver";
  networking.networkmanager.enable = lib.mkForce false;
  networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [
    # Transmission
    51413

    # VNC
    5900

    # NFS
    111
    2049
    20000
    20001
    20002

    # Dev
    8080
  ];
  networking.firewall.allowedUDPPorts = [ 51413 5900 111 2049 20000 20001 20002 8080 ];


  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  swapDevices = [];
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/44b4a02e-1993-4470-b345-b2ca5e3e5b42";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = true;
  };

  services.journald.extraConfig = "SystemMaxUse=500M";
  services.fail2ban = {
    enable = true;
  };
  services.nixosManual.showManual = false;
}