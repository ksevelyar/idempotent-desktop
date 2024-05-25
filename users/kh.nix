args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "kh";
  email = "ts.khol@gmail.com";
  name = "Tatiana Kh";
in {
  imports = [
    (import ./shared.nix (args
      // {
        user = user;
        email = email;
        name = name;
      }))
    (import ../services/x/leftwm.nix (args // {user = user;}))
    (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // {user = user;})))
    (import ../packages/firefox.nix (args // {user = user;}))
  ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/season-01-gas-station-by-dutchtide.png".source = ../assets/wallpapers/season-01-gas-station-by-dutchtide.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl market.lcl
  '';
}
