args @ {
  pkgs,
  config,
  lib,
  ...
}: let
  user = "mr";
  email = "";
  name = "Mr Poppy Butthole";
in {
  imports =
    [
      (import ./shared.nix (args
        // {
          user = user;
          email = email;
          name = name;
        }))
    ]
    ++ [
      (import ../packages/firefox.nix (args // {user = user;}))
    ];

  users.users = {
    ${user} = {
      initialPassword = "id";
    };
  };

  home-manager = {
    users.${user} = {
      home.file."wallpapers/2b.png".source = ../assets/wallpapers/2b.png;
    };
  };
}
