{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  services.pgmanage.enable = false;
  services.postgresql = {
    enable = true;
    authentication = "local all all trust";
  };

  # pg admin dep
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.0.2u"
  ];

  environment.systemPackages = with pkgs;
    [
      # sql
      pgadmin

      # images
      gitg
      imagemagick

      go
      nodejs
      elixir
      inotify-tools
      gcc
    ];
}
