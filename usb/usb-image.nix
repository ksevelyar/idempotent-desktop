{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  imports = [
    ../sys/aliases.nix
    ../sys/tty.nix
    ../sys/sysctl.nix
    ../sys/nix.nix

    ../packages/absolutely-proprietary.nix

    ../services/net/sshd-debug.nix
    ../services/net/avahi.nix
  ];
  home-manager.users.root = {
    home.file.".pi/agent/AGENTS.md".source = ../users/shared/pi/AGENTS.md;
    home.file.".pi/agent/extensions".source = ../users/shared/pi/extensions;
    home.file.".pi/agent/settings.json".source = ../users/shared/pi/settings.json;
    home.file.".pi/agent/models.json".source = ../users/shared/pi/models.json;
    home.file.".pi/agent/keybindings.json".source = ../users/shared/pi/keybindings.json;
  };

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
    pkgs-unstable.pi-coding-agent
    xray
    neovim-unwrapped
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

  isoImage.volumeID = lib.mkForce "nixos-usb";

  networking.hostName = lib.mkForce "id";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;
}
