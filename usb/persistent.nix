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
    ../sys/cache.nix
    ../sys/nix.nix

    ../packages/neovim.nix
    ../packages/absolutely-proprietary.nix
    ../packages/pass.nix

    ../services/x.nix
    ../services/x/unclutter.nix
    ../services/x/redshift.nix
    ../services/vpn.nix
    ../services/net/openvpn.nix
    ../services/net/wireguard.nix
    ../services/net/sshd-debug.nix
    ../services/net/avahi.nix

    ./persistent-disko.nix
  ];

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
      terminus_font
      nerd-fonts.symbols-only
    ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.displayManager = {
    defaultSession = lib.mkDefault "none+leftwm";
  };
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

  services.xserver = {
    videoDrivers = ["nvidia" "amdgpu" "vesa" "modesetting"];
  };
  hardware.nvidia.open = false;

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

    # X
    xxkb
    firefox
    alacritty
    gparted
    xclip
    rofi
    rofimoji
    libnotify
    brightnessctl
    arandr # gui for external monitors
    throne
  ];
}
