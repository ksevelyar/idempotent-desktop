# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "mrpoppybutthole";
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
      (lib.mkIf (config.services.xserver.enable) (import ../services/x/leftwm.nix (args // {user = user;})))
      (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // {user = user;})))
      (lib.mkIf (config.services.xserver.enable) (import ../packages/firefox.nix (args // {user = user;})))
    ];

  users.users = {
    root = {
      initialHashedPassword = lib.mkForce null;
      initialPassword = lib.mkForce "id";
    };

    ${user} = {
      initialPassword = "id";
    };
  };

  home-manager = {
    users.${user} = {
      home.file."wallpapers/2b.png".source = ../assets/wallpapers/2b.png;
    };
  };

  services.getty.autologinUser = lib.mkForce "root";
}
