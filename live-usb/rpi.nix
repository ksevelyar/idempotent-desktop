# FIXME
{ config, pkgs, lib, vars, ... }:
{
  nixpkgs.config.allowUnsupportedSystem = true;

  imports = [
    # <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    ./iso.nix

    ../users/shared.nix
    ../users/live-usb.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/vars.nix
    ../sys/sysctl.nix

    ../services/common.nix
    # ../services/x.nix

    # ../services/x/xmonad.nix
    # ../sys/fonts.nix
    # ../packages/x-common.nix
    # ../packages/x-extra.nix

    ../packages/absolutely-proprietary.nix
    # ../packages/common.nix
    # ../packages/dev.nix
    # ../packages/games.nix
    ../packages/nvim.nix
    ../packages/tmux.nix
    # ../packages/firefox.nix
    ../packages/pass.nix

    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    # ../hardware/power-management.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    # ../services/net/i2pd.nix
    # # ../services/net/i2p.nix
    # ../services/net/tor.nix
    ../services/net/sshd.nix

    #../services/vm/hypervisor.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  sdImage.imageBaseName = lib.mkForce "id-live-arm";
  sdImage.imageName = lib.mkForce "id-live-arm.iso";

  environment = {
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };

    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant-Dracula
        gtk-icon-theme-name=Papirus-Dark-Maia
        gtk-font-name=Terminus 14
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

    # run xfce4-mime-settings to change with gui
    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        inode/directory=spacefm.desktop
        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/ftp=firefox.desktop
        x-scheme-handler/chrome=firefox.desktop
        text/html=firefox.desktop
        application/x-extension-htm=firefox.desktop
        application/x-extension-html=firefox.desktop
        application/x-extension-shtml=firefox.desktop
        application/xhtml+xml=firefox.desktop
        application/x-extension-xhtml=firefox.desktop
        application/x-extension-xht=firefox.desktop
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop
        x-scheme-handler/about=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;
        image/png=nomacs.desktop;
        image/jpeg=nomacs.desktop;
        application/pdf=org.gnome.Evince.desktop;

        [Added Associations]
        x-scheme-handler/http=firefox.desktop;
        x-scheme-handler/https=firefox.desktop;
        x-scheme-handler/ftp=firefox.desktop;
        x-scheme-handler/chrome=firefox.desktop;
        text/html=firefox.desktop;
        application/x-extension-htm=firefox.desktop;
        application/x-extension-html=firefox.desktop;
        application/x-extension-shtml=firefox.desktop;
        application/xhtml+xml=firefox.desktop;
        application/x-extension-xhtml=firefox.desktop;
        application/x-extension-xht=firefox.desktop;
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop;
        application/pdf=org.gnome.Evince.desktop;
        image/jpeg=nomacs.desktop;
        image/png=nomacs.desktop;
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;
      '';
    };

    etc."imv_config".source = ../users/shared/.config/imv/config;
  };

  programs.fish.enable = true;
  programs.browserpass.enable = true;
  programs.qt5ct.enable = true;
  console.useXkbConfig = true;

  programs.spacefm = {
    enable = true;
    settings.source = ../users/shared/.config/spacefm/spacefm.conf;
  };

  environment.systemPackages = with pkgs;
    [
      # sys
      fzf
      ripgrep
      bat
      gitAndTools.delta # https://github.com/dandavison/delta
      # cachix
      home-manager
      libqalculate # qalc
      micro
      watchman
      sipcalc
      tldr
      git
      mkpasswd
      file
      jq
      miller
      ccze
      lnav
      nmap
      wget
      curl
      aria2
      translate-shell
      brightnessctl
      youtube-dl
      ddgr # cli duckduckgo
      googler # cli google
      entr
      termdown
      imagemagick
      sampler

      # net
      firefox
      transmission_gtk

      # monitoring
      # bandwhich
      iperf3
      lm_sensors
      lsof
      hwinfo
      smartmontools
      gotop
      htop
      iotop
      neofetch
      lshw
      pciutils # lspci
      usbutils # lsusb
      # psmisc # pstree, killall
      inetutils

      # sec
      tomb

      # fs
      fd
      exa
      unzip
      unrar
      atool
      bind
      parted
      ffsend
      nnn # curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
      viu
      ncdu
      exa
      z-lua
      dosfstools
      mtools
      sshfs
      ntfs3g
      exfat
      sshfsFuse
      rsync
      rclone # rclone mount gdrive: ~/gdrive/


      # text
      zathura
      hunspell
      hunspellDicts.en_US-large

      # themes
      lxappearance
      vanilla-dmz
      ant-dracula-theme
      papirus-maia-icon-theme

      # sec
      qtpass
      pinentry-gtk2

      # sys
      xxkb
      xorg.xev
      xorg.xfd
      xorg.xkbcomp
      piper # mouse settings
      conky
      xdotool
      seturgent
      alacritty
      maim
      vokoscreen
      xclip
      (rofi.override { plugins = [ rofi-emoji ]; })
      libnotify
      dunst

      # media
      cmus
      glava
      kodi
      glxinfo
      feh
      mpv
      # imv
      libva-utils
      cava
      moc

      # fs
      nomacs
      gparted

      # gui for external monitors
      arandr

      # games for live usb
      rogue
      nethack
    ];
}
