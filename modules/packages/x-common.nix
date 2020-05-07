{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../../assets/layout.xkb} $out
  '';
in
{
  environment.systemPackages = with pkgs;
    [
      # media
      libva-utils
      mpv
      cava
      moc

      # mouse
      piper

      # xmonad defaults
      conky
      xdotool
      seturgent
      stylish-haskell
      alacritty
      rxvt-unicode
      firefoxWrapper
      tor-browser-bundle-bin
      zathura
      evince
      blueman
      # text    
      hunspell
      hunspellDicts.en_US-large
      calibre # epub
      betterlockscreen
      spaceFM

      # themes
      lxappearance-gtk3
      vanilla-dmz
      ant-dracula-theme
      paper-icon-theme

      glxinfo
      feh
      transmission_gtk
      xlsfonts
      xxkb
      xorg.xev
      xorg.xfontsel
      xorg.xfd
      xorg.xkbcomp

      # dev
      notepadqq

      # sec
      qtox
      lxqt.lxqt-policykit
      tdesktop

      # sys
      keepassx-community
      maim
      simplescreenrecorder
      xclip
      rofi
      stable.ulauncher
      pavucontrol
      libnotify
      dunst

      # media
      mpv
      imv
      nomacs

      # fs
      spaceFM

      gparted
      # vncpasswd
      # x0vncserver -rfbauth ~/.vnc/passwd
      tigervnc

      # laptop
      arandr
    ];

  programs.browserpass.enable = true;
  programs.dconf.enable = true;
  programs.qt5ct.enable = true;

  services.picom = {
    enable = true;
    fade = false;
    shadow = false;
    backend = "glx";
    vSync = true;
  };

  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  console.useXkbConfig = true;

  services.xserver = {
    enable = true;

    serverFlagsSection = ''
      Option "BlankTime" "120"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    displayManager.lightdm = {
      enable = true;
      background = "/etc/nixos/assets/displayManager.png";

      greeters.gtk = {
        enable = true;
        cursorTheme = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
        };
      };
    };

    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager = {
      xterm.enable = false;
    };
  };


  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant-Dracula
        gtk-icon-theme-name=Paper-Mono-Dark
        gtk-font-name=Anka/Coder 13
        # gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

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

    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };
}
