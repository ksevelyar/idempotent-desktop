{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      # images
      gitg
      imagemagick

      (python3.withPackages (ps: with ps; [ httpserver ]))
      go
      nodejs
      elixir
      gcc
    ];
}
