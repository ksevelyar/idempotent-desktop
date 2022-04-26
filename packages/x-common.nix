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

    # override with the ~/.config/mimeapps.list that can be edited with xfce4-mime-settings 
    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        inode/directory=spacefm.desktop

        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        text/html=firefox.desktop
        
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;

        image/gif=imv.desktop;
        image/png=imv.desktop;
        image/jpeg=imv.desktop;
        image/jpeg=imv.desktop;
        image/png=imv.desktop;
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
      yt-dlp
      transmission-gtk
      x11vnc # vnc-server
      tigervnc # vncviewer

      # text    
      zathura
      calibre

      # spaced repetition https://docs.ankiweb.net/background.html#spaced-repetition
      anki # https://ankiweb.net/shared/info/110667962

      # themes
      lxappearance
      vanilla-dmz
      dracula-theme
      adwaita-qt
      papirus-maia-icon-theme

      # sec
      qtpass
      keepassx
      pinentry-gtk2

      # im
      element-desktop
      tdesktop

      # sys
      alacritty
      st # alacritty fallback
      gparted
      xxkb
      xorg.xev
      xorg.xfd
      xorg.xkbcomp
      xdotool
      seturgent
      maim # screenshot region or fullscreen
      vokoscreen # record desktop
      xclip
      (rofi.override { plugins = [ rofi-emoji ]; })
      libnotify
      brightnessctl
      arandr # gui for external monitors

      # media
      glxinfo
      feh
      mpv
      libva-utils
      imv # fd -e jpg -e png -e gif . ~/wallpapers/ | shuf | imv
    ];
}
