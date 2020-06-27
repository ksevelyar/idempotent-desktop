{ config, lib, pkgs, ... }:
{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?


  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/sys/debug.nix
      ../modules/sys/aliases.nix
      ../modules/sys/scripts.nix
      ../modules/sys/tty.nix
      ../modules/sys/nix.nix
      ../modules/sys/vars.nix
      ../modules/sys/sysctl.nix

      ../modules/boot/bios.nix
      ../modules/boot/multiboot.nix

      ../modules/services/common.nix
      ../modules/services/x.nix

      ../modules/x/xmonad.nix
      ../modules/x/fonts.nix
      ../modules/packages/x-common.nix
      ../modules/packages/x-extra.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix
      ../modules/packages/games.nix
      ../modules/packages/nvim.nix
      ../modules/packages/tmux.nix
      ../modules/packages/firefox.nix

      ../modules/hardware/bluetooth.nix
      ../modules/hardware/sound.nix
      # ../modules/hardware/power-management.nix

      ../modules/net/firewall-desktop.nix
      ../modules/net/wireguard.nix
      # ../modules/net/i2p.nix
      ../modules/net/tor.nix
      ../modules/net/sshd.nix

      ../modules/vm/hypervisor.nix

      ../users/shared.nix
      ../users/obstinatekate.nix
    ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_1024x768.png;
  # boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  # boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  # boot
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  networking.hostName = "prism";
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.50" ];
      privateKeyFile = "/home/obstinatekate/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "77.37.166.17:51820";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = lib.mkDefault true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  services.xserver = {
    videoDrivers = [ "ati-drivers" ];
    displayManager = {
      sddm.enable = lib.mkForce true;
      lightdm.enable = lib.mkForce false;
    };
  };


  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/32685a01-79cc-4ec0-9d6f-c8708c897a3b nixos
  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };
}
