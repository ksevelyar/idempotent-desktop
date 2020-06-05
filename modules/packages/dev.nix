{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  services.pgmanage.enable = false;
  services.postgresql = {
    package = pkgs.postgresql_12;
    enable = true;
    authentication = ''
      local all all trust
      host all all localhost trust
    '';
  };

  environment.systemPackages = with pkgs;
    [
      universal-ctags
      global

      # git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
      # ~/.emacs.d/bin/doom install
      # emacs

      # docs
      zeal

      # api
      curlie

      # sql
      sequeler

      # images
      imagemagick

      # tools
      stylish-haskell
      stable.nixpkgs-fmt
      # ngrok
      direnv
      lorri
      inotify-tools
      gitg

      # langs
      nodejs_latest
      go
      elixir

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino
    ];
}
