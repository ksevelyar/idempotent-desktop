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
      upwork

      # text

      # boot

      # cli
      calcurse
      wtf
      asciiquarium
      gopass

      # gui
      cura
      google-chrome

      # themes
      conky
      pop-gtk-theme
      adapta-gtk-theme
      ant-theme
      ant-bloody-theme
      nordic
      nordic-polar
      arc-theme
      materia-theme
      adwaita-qt

      # im
      skype
      slack

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

      # dev
      # lazygit
      zeal
      alacritty
      cool-retro-term
      kitty
      asciinema

      # arduino
      arduino
      arduino-core
      fritzing
      ino

      # Freelance

      # sys
      tightvnc
      winusb

      # games
      gzdoom
      stable.steam
      lutris
      playonlinux # https://www.playonlinux.com/en/supported_apps-1-0.html
    ];
}
