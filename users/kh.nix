args@{ config, pkgs, lib, ... }:
let
  user = "kh";
  email = "ts.khol@gmail.com";
  name = "Tatiana Kh";
in
{
  imports = [
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
    (import ../services/x/xmonad.nix (args // { user = user; }))
    (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // { user = user; })))
    (import ../packages/firefox.nix (args // { user = user; }))
  ];

  home-manager = {
    users.${user} = {
      home.file."Wallpapers/Season-01-Gas-station-by-dutchtide.png".source = ../assets/wallpapers/Season-01-Gas-station-by-dutchtide.png;
    };
  };
}
