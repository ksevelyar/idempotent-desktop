{ config, lib, pkgs, ... }:
{
  system.stateVersion = "9000";

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/ksevelyar.nix

      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/scripts.nix
      ../sys/tty.nix
      ../sys/nix.nix
      ../sys/vars.nix

      ../boot/bios.nix


      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/nvim.nix
      ../packages/tmux.nix
      ../packages/pass.nix

      ../services/journald.nix
      ../services/net/murmur.nix
      ../services/net/router.nix
      ../services/net/nginx.nix
      ../services/net/wireguard.nix
      ../services/net/nfs.nix
      ../services/net/sshd.nix
    ];

  services.nginx = {
    virtualHosts."legacy-intelligence.life" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/legacy-intelligence/dist/";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "skynet";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkForce false;

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_1024x768.png;
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
