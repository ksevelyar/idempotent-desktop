{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  services.postgresql = {
    enable = true;
    authentication = "local all all trust";
  };

  environment.systemPackages = with pkgs;
    [
      # sql
      pgmanage
      stable.pgadmin

      # images
      gitg
      imagemagick

      go
      nodejs
      elixir
      gcc
    ];
}
