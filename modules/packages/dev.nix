{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs;
    [

      # ruby
      ruby_2_7
      solargraph # ruby lsp
      zlib
      postgresql

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
      gitAndTools.tig
      lazygit # https://youtu.be/CPLdltN7wgE

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino
    ];
}
