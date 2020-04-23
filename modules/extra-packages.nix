{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.browserpass.enable = true;

  environment.systemPackages = with pkgs;
    [
      # work
      upwork

      # text
      libreoffice

      # boot

      # cli
      stable.khal
      calcurse
      wtf
      asciiquarium

      # gui
      appimage-run
      stable.cura
      google-chrome
      vivaldi
      gimp
      inkscape
      blender
      openscad

      # themes
      conky
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
      tdesktop

      # media
      glava
      audacity
      lmms
      vlc
      kodi
      cmus # Small, fast and powerful console music player for Linux and *BSD
      # fluidsynth # Real-time software synthesizer based on the SoundFont 2 specifications
      # mikmod # Tracker music player for the terminal
      # mpg123 # Fast console MPEG Audio Player and decoder library
      # pianobar # A console front-end for Pandora.com
      # schismtracker # Music tracker application, free reimplementation of Impulse Tracker
      # vorbis-tools # Extra tools for Ogg-Vorbis audio codec
      google-play-music-desktop-player

      # dev
      # lazygit
      zeal
      cool-retro-term
      kitty
      roxterm
      asciinema
      rustc
      cargo

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino

      # sys
      tightvnc
      winusb

      # Freelance
      masterpdfeditor
    ];
}
