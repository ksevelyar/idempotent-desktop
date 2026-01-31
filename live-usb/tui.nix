{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../sys/aliases.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/sysctl.nix
    ../sys/cache.nix

    ../packages/absolutely-proprietary.nix

    ../services/net/avahi.nix # ssh -p 9922 root@tui.local
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir ksevelyar@gmail.com"
      ];
    };
  };

  environment.defaultPackages = lib.mkForce [];
  environment.systemPackages = lib.mkForce (with pkgs; [
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
  ]);

  boot.supportedFilesystems = lib.mkForce {
    btrfs = false;
    cifs = false;
    f2fs = false;
    xfs = false;
    zfs = false;
  };

  documentation.enable = lib.mkForce false;
  documentation.man.generateCaches = lib.mkForce false;

  isoImage.volumeID = lib.mkForce "tui";
  image.fileName = lib.mkForce "tui.iso";

  fonts.packages = with pkgs; [terminus_font];

  networking.hostName = lib.mkForce "tui";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;
}
