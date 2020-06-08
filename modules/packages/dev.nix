{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs;
    [
      # docs
      zeal

      # api
      curlie

      # images
      # imagemagick

      # tools
      universal-ctags
      global
      stylish-haskell
      stable.nixpkgs-fmt
      # ngrok
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.tig
      lazygit # https://youtu.be/CPLdltN7wgE

      # langs
      nodejs_latest
      elixir
      # go

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino
    ];
}
