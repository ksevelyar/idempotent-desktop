{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
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

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino
    ];
}
