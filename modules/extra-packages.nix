{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  services.flatpak.enable = true;
  xdg.portal.enable = true; # flatpak dep
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # flatpak dep

  # upwork
  nixpkgs.overlays = [ (import ../overlays) ];

  environment.systemPackages = with pkgs;
    [
      # work
      syncthing
      upwork
      # memtest86-efi
      # os-prober

      # text
      libreoffice

      # boot

      # cli
      browsh
      stable.khal
      calcurse
      wtf
      asciiquarium

      # gui
      appimage-run
      cura
      google-chrome
      chromium
      vivaldi
      gimp
      inkscape
      blender
      openscad

      # themes
      # pop-gtk-theme
      # adapta-gtk-theme
      ant-theme
      ant-bloody-theme
      # nordic
      # nordic-polar
      # stable.arc-theme
      # materia-theme
      # adwaita-qt
      arc-icon-theme
      zafiro-icons

      # im
      skype
      slack

      # media
      glava
      audacity
      lmms
      vlc
      stable.kodi
      cmus # Small, fast and powerful console music player for Linux and *BSD
      # fluidsynth # Real-time software synthesizer based on the SoundFont 2 specifications
      # mikmod # Tracker music player for the terminal
      # mpg123 # Fast console MPEG Audio Player and decoder library
      # pianobar # A console front-end for Pandora.com
      # schismtracker # Music tracker application, free reimplementation of Impulse Tracker
      # vorbis-tools # Extra tools for Ogg-Vorbis audio codec
      google-play-music-desktop-player
      shortwave # online radio
      fondo # wallpapers

      shotcut # video editor
      openshot-qt
      krita

      # dev
      # lazygit
      rclone
      rclone-browser
      cool-retro-term
      kitty
      roxterm
      asciinema
      rustc
      cargo

      # sys
      tightvnc
      winusb

      # Freelance
      masterpdfeditor
    ];
}
