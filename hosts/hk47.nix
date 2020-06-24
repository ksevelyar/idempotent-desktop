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
      ../users/ksevelyar.nix

      ../modules/sys/aliases.nix
      ../modules/sys/debug.nix
      ../modules/sys/nix.nix
      ../modules/sys/scripts.nix
      ../modules/sys/sysctl.nix
      ../modules/sys/tty.nix
      ../modules/sys/vars.nix

      ../modules/boot/efi.nix
      ../modules/boot/multiboot.nix
      # ../modules/boot/broadcom-wifi.nix

      ../modules/services/common.nix
      ../modules/services/x.nix
      ../modules/services/postgresql.nix
      ../modules/services/mongodb.nix
      # ../modules/services/flatpak.nix

      ../modules/x/xmonad.nix
      ../modules/x/fonts.nix
      ../modules/packages/x-common.nix
      # ../modules/packages/x-extra.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix
      ../modules/packages/games.nix
      ../modules/packages/firefox.nix
      ../modules/packages/nvim.nix
      ../modules/packages/pass.nix
      ../modules/packages/tmux.nix

      ../modules/hardware/bluetooth.nix
      ../modules/hardware/sound.nix

      ../modules/net/firewall-desktop.nix
      # ../modules/net/kresd.nix
      ../modules/net/wireguard.nix
      ../modules/net/i2pd.nix
      ../modules/net/tor.nix
      ../modules/net/sshd.nix
      ../modules/net/openvpn.nix
      ../modules/net/lidarr.nix

      ../modules/vm/hypervisor.nix
      ../modules/vm/docker.nix
    ];

  # build arm from x64, live-usb/rpi.nix for example
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nixpkgs.config.allowUnsupportedSystem = true;

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_1024x768.png;
  # boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  # boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  # boot
  boot.blacklistedKernelModules = [];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  # net
  networking.hostName = "hk47";
  networking.interfaces.enp4s0.useDHCP = true;
  networking.useDHCP = false;
  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = false; # run nmtui for wi-fi

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.47" ];
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

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

  # hardware
  powerManagement.cpuFreqGovernor = "performance";
  services.xserver.videoDriver = "nvidia";
  # services.xserver.videoDrivers = [ "nouveau" ];
  services.picom = {
    enable = true;
    fade = false;
    backend = "glx";
    # backend = "xrender";
    vSync = true;
  };

  # Fix smooth scroll in Firefox
  # services.xserver.screenSection = ''
  # Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
  # '';
  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia.modesetting.enable = true;
    pulseaudio.configFile = ../users/ksevelyar/default.pa;
  };

  # fs
  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/044a758f-4252-4e42-b68c-a87d2345dc4c nixos
  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  # sudo fatlabel /dev/disk/by-uuid/3A05-EA05 boot
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  # sudo e2label /dev/disk/by-uuid/bd7a95b1-0a44-4477-8616-177b95561ad1 storage
  fileSystems."/storage" =
    {
      device = "/dev/disk/by-label/storage";
      fsType = "ext4";
      options = [ "noatime" ];
    };

  fileSystems."/skynet" = {
    device = "192.168.0.1:/export";
    fsType = "nfs";

    # don't freeze system if mount point not available on boot
    options = [ "x-systemd.automount" "noauto" ];
  };
}
