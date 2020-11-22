{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs;
    [
      # work
      # syncthing
      # masterpdfeditor

      thunderbird-bin
      qalculate-gtk
      # wireshark-qt
      notepadqq
      # neovim-qt

      # cli
      roxterm # fallback terminal
      # browsh # cli browser

      # gui
      # pywal
      # appimage-run
      # chromium
      # vivaldi

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
      # simplescreenrecorder
      # audacious
      # lmms
      ffmpeg
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
