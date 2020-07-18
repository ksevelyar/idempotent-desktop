{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest
      elixir

      # lsp
      rnix-lsp
      clang-tools

      # tools
      zeal # docs
      curlie # api
      imagemagick
      universal-ctags
      global
      # ngrok
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui

      stable.fritzing
      librepcb
      xoscope

      # arduino
      # arduino --board arduino:avr:nano --port /dev/ttyUSB0 --upload shroom-box.ino
      arduino
      arduino-core

      # esp8266 / 32
      esptool
      # nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A arduino
    ];
}
