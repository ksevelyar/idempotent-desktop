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
  # i18n.inputMethod = {
  #   enabled = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [ table table-others anthy mozc hangul uniemoji ];
  # };


  environment.systemPackages = with pkgs;
    [
      # media
      # sweet
      # pantheon.elementary-icon-theme
      # ibus-qt
      # ibus-with-plugins
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
      # text    
      hunspell
      hunspellDicts.en_US-large
      calibre # epub
      spaceFM

      # themes
      lxappearance-gtk3
      vanilla-dmz
      ant-dracula-theme
      papirus-icon-theme
      papirus-maia-icon-theme

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

      # sec
      qtox
      tdesktop

      # sys
      keepassx-community
      maim
      simplescreenrecorder
      xclip
      qalculate-gtk
      (rofi.override { plugins = [ rofi-file-browser rofi-emoji rofi-pass rofi-systemd rofi-calc ]; })
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
      x11vnc
      # x2goclient

      # laptop
      arandr
    ];

  programs.browserpass.enable = true;
  programs.dconf.enable = true;
  programs.qt5ct.enable = true;
}
