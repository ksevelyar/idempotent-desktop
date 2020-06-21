{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
  upwork = pkgs.callPackage ./upwork.nix {};
  # TODO: pack neovide
  # neovide = pkgs.callPackage ./neovide.nix {};
in
{
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

    etc."imv_config".source = ../../home/.config/imv/config;
  };

  programs.browserpass.enable = true;
  programs.qt5ct.enable = true;
  console.useXkbConfig = true;

  programs.spacefm = {
    enable = true;
    settings.source = ../../home/.config/spacefm/spacefm.conf;
  };

  environment.systemPackages = with pkgs;
    [
      # net
      firefox
      google-chrome
      transmission_gtk
      (mumble.override { pulseSupport = true; })
      x11vnc # vnc-server
      tigervnc # vncviewer

      # text    
      zathura
      hunspell
      hunspellDicts.en_US-large

      # themes
      lxappearance
      vanilla-dmz
      ant-dracula-theme
      stable.papirus-maia-icon-theme

      # sec
      qtpass
      keepassx-community
      pinentry-gtk2
      qtox
      tdesktop

      # mail
      astroid # notmuch gui

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
      (rofi.override { plugins = [ rofi-emoji rofi-calc ]; })
      libnotify
      dunst
      nix-du
      graphviz

      # media
      glxinfo
      feh
      spotify
      mpv # https://github.com/mpv-player/mpv/blob/master/etc/input.conf
      vlc
      stable.kodi
      imv
      libva-utils
      glava

      # fs
      nomacs
      gparted

      # gui for external monitors
      arandr

      # freelance (hire me)
      upwork
      skype

      # 3d print
      # https://www.thingiverse.com/ksevelyar/likes
      slic3r-prusa3d
      openscad

      # gfx
      gimp
      inkscape
      blender
    ];
}
