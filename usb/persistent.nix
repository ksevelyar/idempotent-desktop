args @ {
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/mr.nix
    ../users/root.nix

    ../sys/aliases.nix
    ../sys/tty.nix
    ../sys/sysctl.nix
    ../sys/nix.nix

    ../packages/wayland-common.nix
    ../packages/neovim.nix
    ../packages/absolutely-proprietary.nix
    ../packages/pass.nix

    ../services/wayland/hyprland.nix
    ../services/net/wireguard.nix
    ../services/net/sshd-debug.nix
    ../services/net/avahi.nix

    ./persistent-disko.nix
  ];

  home-manager.users.mr = {
    home.file.".config/hypr/hypridle.conf".source = ../users/ksevelyar/laundry/hypr/hypridle.conf;
    home.file.".config/hypr/hyprland.conf".source = ../users/ksevelyar/laundry/hypr/hyprland.conf;
    home.file.".config/waybar/config-top".source = ../users/ksevelyar/laundry/waybar/waybar-top.json;
    home.file.".config/waybar/config-bottom".source = ../users/ksevelyar/laundry/waybar/waybar-bottom.json;
    home.file.".config/waybar/style.css".source = ../users/ksevelyar/laundry/waybar/waybar.css;

    home.file.".config/alacritty/alacritty.toml".source = ../users/ksevelyar/laundry/alacritty/alacritty.toml;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = lib.mkForce false;
  };

  services.journald.extraConfig = ''
    Storage=volatile
  '';

  boot.loader.systemd-boot.configurationLimit = 1;
  boot.tmp.useTmpfs = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false; # don't touch disk when booted from USB

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];

  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.caskaydia-mono
      terminus_font
    ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.fish.interactiveShellInit = "ip -br addr";
  services.getty.autologinUser = "mr";
  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir ksevelyar@gmail.com"
      ];
      initialPassword = lib.mkForce "id";
    };
  };

  networking.hostName = lib.mkForce "id";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;

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
    fastfetch

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

    firefox
    alacritty
    gparted
    brightnessctl
  ];
}
