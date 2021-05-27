{ config, lib, pkgs, ... }:
{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?


  imports =
    [
      ../users/obstinatekate.nix

      ../hardware/bluetooth.nix
      ../hardware/mouse.nix
      ../hardware/sound.nix
      # ../hardware/power-management.nix

      ../sys/aliases.nix
      ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/vars.nix
      ../sys/fonts.nix

      ../boot/bios.nix
      ../boot/multiboot.nix

      ../services/journald.nix
      ../services/postgresql.nix
      ../services/redis.nix
      ../services/x.nix
      ../services/x/picom.nix
      ../services/x/xmonad.nix

      ../packages/x-common.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/x-common.nix
      ../packages/dev.nix
      # ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      ../packages/firefox.nix

      ../services/net/fail2ban.nix
      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      # ../services/net/i2p.nix
      # ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      ../services/net/nginx.nix

      # ../services/vm/hypervisor.nix
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
          endpoint = "95.165.99.133:51821";

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

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
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
