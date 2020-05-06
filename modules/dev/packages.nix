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
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.0.2u"
  ];

  environment.systemPackages = with pkgs;
    [
      # docs
      zeal

      # api
      curlie

      # sql
      pgadmin
      dbeaver

      # images
      imagemagick

      # tools
      ngrok
      direnv
      inotify-tools
      gitg

      # langs
      go
      elixir
      gcc

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino
    ];
}
