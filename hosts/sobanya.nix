args @ {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/manya.nix
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/bios.nix
    ../hardware/multiboot.nix
    ../hardware/bluetooth.nix
    ../hardware/mouse.nix
    ../hardware/intel-cpu.nix
    ../hardware/pipewire.nix
    ../hardware/ssd.nix

    ../sys/aliases.nix
    ../sys/fonts.nix
    ../sys/nix.nix
    ../sys/sysctl.nix
    ../sys/tty.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/x-common.nix
    ../packages/3d-print.nix
    ../packages/electronics.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/pass.nix
    ../packages/freelance.nix

    ../services/journald.nix
    ../services/databases/postgresql.nix
    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix

    ../services/net/firewall-desktop.nix
    ../services/net/sshd.nix
    ../services/net/wireguard.nix

    ../services/vm/hypervisor.nix
    # ../services/vm/docker.nix
  ];

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.blacklistedKernelModules = [];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
  boot.kernelModules = ["kvm-intel" "wl"];
  boot.extraModulePackages = [config.boot.kernelPackages.broadcom_sta];

  # net
  networking.hostName = "sobanya";
  networking.interfaces.enp3s0.useDHCP = true;
  networking.useDHCP = false;
  networking.networkmanager.enable = true; # run nmtui for wi-fi

  services.displayManager = {
    defaultSession = "none+leftwm";
  };

  # x
  services.xserver = {
    videoDrivers = ["nouveau" "modesetting"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
}
