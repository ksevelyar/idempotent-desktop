{ config, pkgs, ... }:
let
  python-packages = python-packages: with python-packages; [
    pywal
  ];
in
{
  environment.systemPackages = with pkgs;
    [
      # (python3.withPackages python-packages)
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

      # esp8266
      esptool
      # nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A arduino
    ];
}
