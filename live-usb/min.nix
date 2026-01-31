# nix build /etc/nixos#nixosConfigurations.live-usb-min.config.system.build.isoImage
{
  config,
  modulesPath,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../users/root.nix

    ../sys/aliases.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/sysctl.nix
    ../sys/cache.nix

    ../packages/absolutely-proprietary.nix

    ../services/net/avahi.nix # ssh -p 9922 root@id-live-min.local
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
    auto = true;
    btrfs = false;
    cifs = false;
    f2fs = false;
    ntfs = true;
    overlay = true;
    squashfs = true;
    tmpfs = true;
    vfat = true;
    xfs = false;
    zfs = false;
  };

  documentation.enable = lib.mkForce false;
  documentation.man.generateCaches = lib.mkForce false;

  isoImage.volumeID = lib.mkForce "id-live-min";
  image.fileName = lib.mkForce "id-live-min.iso";

  fonts.packages = with pkgs; [terminus_font];

  networking.hostName = lib.mkForce "id-live-min";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;
}
