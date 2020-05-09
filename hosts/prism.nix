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
      ../modules/sys/aliases.nix
      ../modules/sys/scripts.nix
      # ../modules/sys/debug.nix

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

      ../modules/hardware/bluetooth.nix
      ../modules/hardware/sound.nix
      ../modules/hardware/ssd.nix
      ../modules/hardware/laptop.nix

      ../modules/net/firewall-desktop.nix
      ../modules/net/wireguard.nix

      ../modules/vm/hypervisor.nix

      ../users/obstinatekate.nix
    ];

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.5" ];
      privateKeyFile = "/home/obstinatekate/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";

          allowedIPs = [ "192.168.42.0/24" ];

          # Set this to the server IP and port.
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
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networkin  fileSystems."/mnt/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
  };
  g.hostName = "prism"; # Define your hostname.

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  services.xserver = {
    videoDrivers = [ "ati-drivers" ];
    displayManager = {
      sessionCommands = ''
        (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &
        sh ~/.fehbg
        xsetroot -cursor_name left_ptr
        
        lxqt-policykit-agent &
        xxkb &
        xcape -e 'Super_R=Super_R|X'
      '';
    };
  };

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.plymouth.enable = false;

  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/32685a01-79cc-4ec0-9d6f-c8708c897a3b nixos
  fileSystems."/" =
    {
      # device = "/dev/disk/by-label/nixos";
      device = "/dev/disk/by-uuid/32685a01-79cc-4ec0-9d6f-c8708c897a3b";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };
}
