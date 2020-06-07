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
      # docs
      zeal

      # api
      curlie

      # sql
      sequeler

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

      # git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
      # ~/.emacs.d/bin/doom install
      # emacs
    ];
}
