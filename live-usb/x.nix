args @ {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../users/live-usb.nix
    ../users/root.nix

    ../sys/aliases.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/sysctl.nix
    ../sys/cache.nix

    ../packages/absolutely-proprietary.nix

    ../services/x/redshift.nix
    ../services/net/avahi.nix # ssh -p 9922 root@x.local
  ];

  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      dejavu_fonts
      terminus_font
    ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.displayManager.defaultSession = lib.mkDefault "none+leftwm";

  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = lib.mkDefault "adaptive";
      disableWhileTyping = true;
      clickMethod = "buttonareas";
      scrollMethod = lib.mkDefault "edge";
      naturalScrolling = false;
    };
  };

  services.xserver = {
    enable = true;

    displayManager.lightdm = {
      enable = true;
      greeters.slick = {
        enable = true;
        theme = {
          name = "Dracula";
          package = pkgs.dracula-theme;
        };
        cursorTheme = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
        };

        extraConfig = ''
          show-hostname=false
          show-a11y=false
          show-power=false
          show-keyboard=false
          show-clock=false
          show-quit=false
        '';
      };
    };

    xkb.layout = "us,ru";
    # use Caps Lock to toggle layouts and turn on Caps Look's led for ru layout
    xkb.options = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager.xterm.enable = false;
  };

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir ksevelyar@gmail.com"
      ];
    };
  };

  services.speechd.enable = false;

  documentation.enable = lib.mkForce false;
  documentation.man.generateCaches = lib.mkForce false;

  environment.defaultPackages = lib.mkForce [];
  environment.systemPackages = with pkgs; [
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

  boot.supportedFilesystems = lib.mkForce {
    btrfs = false;
    cifs = false;
    f2fs = false;
    xfs = false;
    zfs = false;
  };

  isoImage.volumeID = lib.mkForce "x";
  image.fileName = lib.mkForce "x.iso";

  networking.hostName = lib.mkForce "x";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "mrpoppybutthole";
    };
  };
  services.xserver = {
    videoDrivers = ["nvidia" "amdgpu" "vesa" "modesetting"];
  };

  hardware.nvidia.open = false;
}
