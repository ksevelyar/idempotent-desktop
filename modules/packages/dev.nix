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

  # pg admin dep
  # nixpkgs.config.permittedInsecurePackages = [
  #   "openssl-1.0.2u"
  # ];

  environment.systemPackages = with pkgs;
    [
      universal-ctags
      global

      emacs
      codeql

      # docs
      zeal

      # api
      curlie

      # sql
      # pgadmin
      dbeaver
      sequeler

      # images
      imagemagick

      # tools
      stable.nixpkgs-fmt
      # ngrok
      direnv
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
