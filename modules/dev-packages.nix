{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    authentication = "local all all trust";
  };

  environment.systemPackages = with pkgs;
    [
      # images
      gitg
      imagemagick

      go
      nodejs
      elixir
      gcc
    ];
}
