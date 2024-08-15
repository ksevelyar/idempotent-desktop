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
      (import ../services/mpd/mpdscribble.nix (args
        // {
          user = user;
          listenbrainz_user = user;
        }))

      (import ../services/wayland/hyprland.nix (args // {user = user;}))
      (import ../packages/firefox.nix (args // {user = user;}))
    ]
    ++ [
    ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/2b.png".source = ../assets/wallpapers/2b.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl habits.lcl market.lcl
  '';
}
