args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "ksevelyar";
  email = "ksevelyar@protonmail.com";
  name = "Sergey Zubkov";
in {
  imports =
    [
      (import ./shared.nix (args
        // {
          user = user;
          email = email;
          name = name;
        }))
      (import ../services/mpd.nix (args // {user = user;}))
    ]
    ++ [
      (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // {user = user;})))
      (lib.mkIf (config.services.xserver.enable) (import ../services/x/leftwm.nix (args // {user = user;})))
      (lib.mkIf (config.services.xserver.enable) (import ../packages/firefox.nix (args // {user = user;})))
    ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/2b.png".source = ../assets/wallpapers/2b.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl habits.lcl market.lcl buzz.lcl
  '';
}
