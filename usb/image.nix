{
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
  ];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.getty.autologinUser = lib.mkForce "root";
  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir ksevelyar@gmail.com"
      ];
      initialHashedPassword = lib.mkForce null;
      initialPassword = lib.mkForce "id";
    };
  };

  environment.defaultPackages = [];
  environment.systemPackages = with pkgs; [
    bash
    neovim
    zoxide
    bat
    fd
    fzf
    gitMinimal
    ripgrep
    tealdeer
    bottom
    ncdu
    rsync
    macchina

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

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = lib.mkForce {
    btrfs = false;
    cifs = false;
    f2fs = false;
    xfs = false;
    zfs = false;
  };

  documentation.enable = lib.mkForce false;
  documentation.man.generateCaches = lib.mkForce false;

  isoImage.volumeID = lib.mkForce "nixos-usb";

  networking.hostName = lib.mkForce "id";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;
}
