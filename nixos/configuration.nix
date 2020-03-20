# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio.support32Bit = true; # Required for Steam
    bluetooth.enable = true;

    # With Kernel Mode Setting (KMS), the kernel is now able to set the mode of the video card.
    # This makes fancy graphics during bootup, virtual console and X fast switching possible, among other things.
    nvidia.modesetting.enable = true;
    brightnessctl.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
  };

  # https://nixos.wiki/wiki/Bluetooth

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  #boot.loader.systemd-boot.consoleMode = "max";
  # boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "quiet" ];
  boot.consoleLogLevel = 3;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    # device = "/dev/sda"; MBR/BIOS
    version = 2;
    efiSupport = true;
    backgroundColor = "#35246e";
    memtest86.enable = false;
    configurationLimit = 42;
    useOSProber = true;

    #extraConfig = "set theme=${pkgs.breeze-grub}/grub/themes/breeze/theme.txt";
    splashImage = "/etc/nixos/grub.jpg";
    splashMode = "normal";
    font = "/etc/nixos/ter-u16n.pf2";
    extraConfig = ''
      set menu_color_normal=light-blue/black
      set menu_color_highlight=black/light-blue
    '';
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.tmpOnTmpfs = true;
  boot.plymouth.enable = false;

  networking.hostName = "laundry"; # Define your hostname.

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 51413 5900 ]; # Transmission
  networking.firewall.allowedUDPPorts = [ 51413 5900 ];
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.extraHosts =
    ''
      127.0.0.1 li.lcl
    '';

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  location.latitude = 55.75;
  location.longitude = 37.61;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      grub2
      os-prober
      hwinfo
      wget
      curl

      # cli
      wtf

      mpv
      smplayer
      vlc
      kodi
      xbindkeys
      fzf
      gopass
      keepassxc
      firefoxWrapper
      google-chrome
      zathura
      dzen2
      memtest86-efi

      # Themes
      ant-theme
      arc-theme
      materia-theme
      paper-icon-theme
      lxappearance-gtk3
      lxqt.lxqt-themes
      adwaita-qt
      skype
      slack
      feh
      transmission_gtk
      tdesktop
      mirage
      polybar
      xorg.xev

      # Audio
      unstable.google-play-music-desktop-player
      audacity
      lmms

      # Dev
      neovim
      vscode
      ripgrep
      tldr
      nodejs
      elixir
      go
      terminator
      cool-retro-term
      kitty
      asciinema
      alacritty
      universal-ctags
      global
      gcc
      git
      gitg
      gitAndTools.diff-so-fancy
      lazygit
      imagemagick
      gimp

      # Freelance
      libreoffice
      masterpdfeditor

      # Sys
      memtest86plus
      system-config-printer

      ## fs
      mc
      spaceFM
      xfce.thunar
      exa
      fd
      ranger
      libcaca
      nomacs
      ncdu
      tree
      rsync
      sshfs
      ntfs3g
      exfat
      sshfsFuse
      rclone
      rclone-browser

      lshw
      bat
      inetutils
      maim
      simplescreenrecorder
      smartmontools
      bind
      xmobar
      unzip
      xclip
      gotop
      iotop
      powertop
      rofi
      redshift
      bash
      tor-browser-bundle-bin
      pavucontrol
      libnotify
      dunst
      nixpkgs-fmt
      tightvnc

      # vncpasswd
      # x0vncserver -rfbauth ~/.vnc/passwd
      tigervnc

      steam
      mcomix
      neofetch

      # laptop
      arandr
      acpi
      ulauncher
      openssh

      winusb
    ];

    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant
        gtk-icon-theme-name=Paper-Mono-Dark
        gtk-font-name=Anka/Coder 13
        gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name=Paper
      '';
    };

    # usr."share/icons/default/index.theme" = {
    #   text = ''
    #     [icon theme]
    #     Inherits=Paper
    #     '';
    #   };


    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        inode/directory=spacefm.desktop

        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/ftp=firefox.desktop
        x-scheme-handler/chrome=firefox.desktop
        text/html=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
      '';
    };

    etc."xdg/nvim/sysinit.vim".text = builtins.readFile ./init.vim;

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.browserpass.enable = true;

  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.tmux.enable = true;
  programs.qt5ct.enable = true;

  programs.thefuck.enable = true; # https://github.com/nvbn/thefuck

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    #   drivers = [ pkgs.gutenprint pkgs.hplip ];
  };

  # Enable sound.
  sound.enable = true;

  # Enable the X11 windowing system.
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      opensans-ttf
      nerdfonts
      powerline-fonts
      ankacoder
    ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply"
    ATTR{status}=="Discharging"
    ATTR{capacity}=="[0-10]"
    RUN+="${pkgs.libnotify}/bin/notify-send 'Low Battery' 'HRU'"
  '';

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  # Auto-detect the connected display hardware and load the appropriate X11 setup using xrandr
  # services.autorandr.enable = true;

  services.syncthing = {
    enable = true;
    user = "ksevelyar";
    dataDir = "/home/ksevelyar/.syncthing";
    openDefaultPorts = true;
  };

  services.blueman.enable = true;
  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=85
    STOP_CHARGE_THRESH_BAT0=95
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
  '';

  services.tor = {
    enable = true;
    client.enable = true;
  };

  # Services
  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };
    videoDrivers = [ "nouveau" "intel" "amdgpu" ];
    # videoDrivers = [ "intel" ];
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager = {
      default = "none";
      xterm.enable = false;
      gnome3.enable = true;
    };

    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      xmonad.extraPackages = hpkgs: [
        hpkgs.xmonad-contrib
        hpkgs.xmonad-extras
        hpkgs.xmonad
      ];
      default = "xmonad";
    };
  };

  services.udisks2.enable = true;
  # services.devmon.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;

    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.openssh.permitRootLogin = "no";
  services.openssh.enable = true;
  # Allow sshd to be started manually through sudo systemctl start sshd
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [];

  services.journald.extraConfig = "SystemMaxUse=500M";

  services.fail2ban.enable = true;
  services.fail2ban.jails.DEFAULT = ''
    ignoreip = 127.0.0.1/8
    bantime = 600
    findtime = 600
    maxretry = 3
    backend = auto
    enabled = true
  '';

  services.nixosManual.showManual = true;

  users.defaultUserShell = pkgs.fish;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ksevelyar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };

  # home-manager = {
  #   users.ksevelyar = {
  #     programs.git = {
  #       enable = true;
  #       userName = "Sergey Zubkov";
  #       userEmail = "ksevelyar@gmail.com";
  #     };
  #
  #     # programs.neovim.enable = true;
  #   };
  # };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.

  nix.binaryCaches = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

  system.stateVersion = "19.09"; # Did you read the comment?
  system.autoUpgrade.enable = true;
}
