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

      ../services/common.nix
      ../services/x.nix

      ../services/x/xmonad.nix
      ../sys/fonts.nix
      ../packages/x-common.nix
      ../packages/x-extra.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/pass.nix
      ../packages/tmux.nix
      # ../packages/firefox.nix

      ../hardware/bluetooth.nix
      ../hardware/sound.nix
      # ../hardware/power-management.nix

      ../services/net/firewall-desktop.nix
      ../services/net/wireguard.nix
      ../services/net/i2pd.nix
      ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/openvpn.nix
      ../services/net/nginx.nix
      # ../services/net/lidarr.nix

      ../services/vm/hypervisor.nix
    ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  services.xserver = {
    libinput = {
      enable = true;
      # accelProfile = "flat"; # flat profile for touchpads
      naturalScrolling = false;
      disableWhileTyping = true;
      clickMethod = "buttonareas";
      # scrollMethod = "edge";
    };

    # config = ''
    #   Section "InputClass"
    #     Identifier "Mouse"
    #     Driver "libinput"
    #     MatchIsPointer "on"
    #     Option "AccelProfile" "adaptive"
    #     Option "AccelSpeed" "0.8"
    #   EndSection
    # '';
  };

  networking.hostName = "pepes";
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.3" ];
      privateKeyFile = "/home/kh/wireguard-keys/private";

      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "77.37.166.17:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  fileSystems."/skynet" = {
    device = "192.168.42.1:/export";
    fsType = "nfs";
  };

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
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

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
  services.xserver.videoDrivers = [ "intel" ];

  # console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  # services.xserver.dpi = 180;
  # environment.variables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };
}
