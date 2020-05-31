{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  programs.browserpass.enable = true;
  programs.dconf.enable = true;
  programs.qt5ct.enable = true;

  environment = {
    etc."imv_config".source = ../../home/.config/imv/config;
  };

  environment.systemPackages = with pkgs;
    [
      # mouse
      piper
      conky
      xdotool
      seturgent
      stylish-haskell
      alacritty
      roxterm # fallback terminal
      firefoxWrapper
      zathura
      evince
      # text    
      hunspell
      hunspellDicts.en_US-large
      calibre # epub
      spaceFM

      # themes
      lxappearance-gtk3
      vanilla-dmz
      ant-dracula-theme
      # papirus-icon-theme
      stable.papirus-maia-icon-theme

      # paper-icon-theme
      # deepin.deepin-icon-theme
      # elementary-xfce-icon-theme
      # faba-icon-theme
      # maia-icon-theme
      # mate.mate-icon-theme
      # mate.mate-icon-theme-faenza
      # moka-icon-theme
      # numix-icon-theme
      # cinnamon.mint-y-icons
      # flat-remix-icon-theme

      glxinfo
      transmission_gtk
      feh
      xlsfonts
      xxkb
      xorg.xev
      xorg.xfontsel
      xorg.xfd
      xorg.xkbcomp

      # voip
      (pkgs.mumble.override { pulseSupport = true; })

      # sec
      tor-browser-bundle-bin
      openvpn
      qtpass
      pinentry-gtk2
      qtox
      tdesktop

      # sys
      keepassx-community
      maim
      vokoscreen
      simplescreenrecorder
      peek
      xclip
      qalculate-gtk
      (rofi.override { plugins = [ rofi-file-browser rofi-emoji rofi-systemd rofi-calc ]; })
      rofi-pass
      pavucontrol
      libnotify
      dunst
      etcher # write live usb with gui

      # media
      # ncspot # requires premium
      spotify
      mpv
      imv
      nomacs

      # fs
      spaceFM

      gparted
      # x11vnc -repeat -forever -noxrecord -noxdamage -rfbport 5900
      tigervnc
      x11vnc
      # x2goclient

      # laptop
      arandr

      # sweet
      # pantheon.elementary-icon-theme
      # ibus-qt
      # ibus-with-plugins
      libva-utils
      cava
      moc
    ];
}
