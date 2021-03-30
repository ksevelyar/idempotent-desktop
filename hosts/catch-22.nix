{ config, lib, pkgs, ... }:
{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?


  imports =
    [
      ../users/shared.nix
      ../users/kh.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/vars.nix

      ../boot/efi.nix
      ../boot/multiboot.nix

      ../services/x.nix

      ../services/x/xmonad.nix
      ../sys/fonts.nix
      ../packages/x-common.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      ../packages/firefox.nix

      ../hardware/bluetooth.nix
      ../hardware/sound.nix
      ../hardware/ssd.nix
      # ../hardware/laptop.nix

      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      # ../services/net/lidarr.nix
      ../services/net/nginx.nix

      ../services/vm/hypervisor.nix
    ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  networking.hostName = "catch-22";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # mkdir -p ~/wireguard-keys && cd ~/wireguard-keys && umask 077
  # wg genkey | tee private | wg pubkey > public
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.10" ];
      privateKeyFile = "/home/kh/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
  };

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/21520a28-cf26-42a0-aaf6-17f8e6e62f36";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/88D8-38E9";
      fsType = "vfat";
    };

  swapDevices = [];

  hardware = {
    cpu.intel.updateMicrocode = true;
    # pulseaudio.configFile = ../users/shared/disable-hdmi.pa;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  # services.xserver.dpi = 180;
  # environment.variables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };
}
