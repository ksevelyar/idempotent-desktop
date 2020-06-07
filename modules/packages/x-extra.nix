{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  # upwork
  nixpkgs.overlays = [ (import ../../overlays) ];


  environment.systemPackages = with pkgs;
    [
      # work
      # syncthing
      upwork
      keepassx-community
      # masterpdfeditor
      # memtest86-efi
      # os-prober

      # office
      libreoffice-fresh
      thunderbird-bin

      # cli
      roxterm # fallback terminal
      browsh # cli browser
      googler

      # gui
      pywal
      vlc
      # appimage-run
      stable.cura
      google-chrome
      # chromium
      # vivaldi
      gimp
      inkscape
      blender
      openscad

      # themes
      # pop-gtk-theme
      # adapta-gtk-theme
      # ant-theme
      # ant-bloody-theme
      # nordic
      # nordic-polar
      # stable.arc-theme
      # materia-theme
      # adwaita-qt
      # arc-icon-theme
      # zafiro-icons
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

      # im
      # skype
      # slack

      # media
      # ncspot # requires premium
      glava
      simplescreenrecorder
      # audacious
      # lmms
      vlc
      stable.kodi
      cmus # Small, fast and powerful console music player for Linux and *BSD
      # fluidsynth # Real-time software synthesizer based on the SoundFont 2 specifications
      # mikmod # Tracker music player for the terminal
      # mpg123 # Fast console MPEG Audio Player and decoder library
      # schismtracker # Music tracker application, free reimplementation of Impulse Tracker
      # vorbis-tools # Extra tools for Ogg-Vorbis audio codec
      # google-play-music-desktop-player
      # shortwave # online radio

      # shotcut # video editor
      # openshot-qt

      # dev
      cool-retro-term
      asciinema

      # sys
      # tightvnc
      woeusb # write win10.iso to usb drive

    ];
}
