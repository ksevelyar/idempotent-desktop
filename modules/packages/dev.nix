{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest
      elixir

      # tools
      zeal # docs
      curlie # api
      imagemagick
      universal-ctags
      global
      stylish-haskell
      stable.nixpkgs-fmt
      # ngrok
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui

      stable.fritzing

      # arduino
      # arduino --board arduino:avr:nano --port /dev/ttyUSB0 --upload shroom-box.ino
      arduino
      arduino-core

      # esp8266
      esptool
      # nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A arduino
    ];
}
