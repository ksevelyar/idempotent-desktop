{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../sys/aliases.nix
    ../sys/tty.nix
    ../sys/sysctl.nix
    ../sys/cache.nix

    ../packages/absolutely-proprietary.nix

    ../services/net/sshd-debug.nix
    ../services/net/avahi.nix

    ./persistent-disko.nix
  ];

  services.fstrim.enable = true;

  services.journald.extraConfig = ''
    RuntimeMaxUse=100M
    RateLimitIntervalSec=30s
    RateLimitBurst=2000
  '';

  system.stateVersion = "25.11";
  documentation.enable = false;
  documentation.man.generateCaches = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = lib.mkForce {
    btrfs = false;
    cifs = false;
    f2fs = false;
    xfs = false;
    zfs = false;
  };
  boot.loader.systemd-boot.configurationLimit = 1;
  boot.tmp.useTmpfs = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false; # don't touch disk when booted from USB

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.getty.autologinUser = "root";
  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir ksevelyar@gmail.com"
      ];
      initialPassword = lib.mkForce "id";
    };
  };

  environment.defaultPackages = [];
  environment.systemPackages = with pkgs; [
    neovim
    zoxide
    bat
    fd
    fzf
    ripgrep
    tealdeer
    bottom
    ncdu
    rsync
    neofetch

    parted
    gptfdisk
    cryptsetup

    lshw
    pciutils
    usbutils
    nvme-cli
    sshfs
    smartmontools
    dosfstools
    ntfs3g

    zip
    unzip
  ];

  networking.hostName = lib.mkForce "id";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;
}
