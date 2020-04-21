{ config, pkgs, ... }:

{
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
