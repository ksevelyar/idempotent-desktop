{ config, pkgs, lib, ... }:
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
        gtk-theme-name=Dracula
        gtk-icon-theme-name=Papirus-Dark-Maia
        gtk-font-name=Terminus 16
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

    # run xfce4-mime-settings to change with gui
    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        application/javascript=nvim.desktop;
        application/json=nvim.desktop;
        text/plain=nvim.desktop;
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
        image/jpeg=nomacs.desktop;imv.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;imv.desktop;

        [Added Associations]
        application/javascript=nvim.desktop;
        application/json=nvim.desktop;
        text/markdown=nvim.desktop;
        text/plain=nvim.desktop;
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
        image/jpeg=nomacs.desktop;imv.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;      
      '';
    };

    etc."imv_config".source = ../users/shared/.config/imv/config;
  };

  programs.browserpass.enable = true;
  programs.qt5ct.enable = true;
  console.useXkbConfig = true;

  programs.spacefm = {
    enable = true;
    settings.source = ../users/shared/.config/spacefm/spacefm.conf;
  };

  environment.systemPackages = with pkgs;
    [
      # net
      firefox
      google-chrome
      transmission_gtk
      x11vnc # vnc-server
      tigervnc # vncviewer

      # text    
      zathura
      calibre
      anki

      # themes
      lxappearance
      vanilla-dmz
      dracula-theme
      adwaita-qt
      papirus-maia-icon-theme

      # sec
      qtpass
      keepassx-community
      pinentry-gtk2

      # im
      element-desktop
      tdesktop

      # sys
      gparted
      xxkb
      xorg.xev
      xorg.xfd
      xorg.xkbcomp
      piper # mouse settings
      conky
      xdotool
      seturgent
      alacritty
      roxterm 
      cool-retro-term
      maim # screenshot region or fullscreen
      vokoscreen # record desktop
      xclip
      (rofi.override { plugins = [ rofi-emoji ]; })
      libnotify

      # media
      glxinfo
      feh
      spotify
      playerctl
      mpv # https://github.com/mpv-player/mpv/blob/master/etc/input.conf
      vlc
      kodi
      libva-utils
      glava

      # images
      imv
      nomacs
      ahoviewer

      # gui for external monitors
      arandr

      # gfx
      gimp
      inkscape
      # blender
    ];
}
