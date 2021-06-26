# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
args@{ config, pkgs, lib, ... }:
let
  user = "mrpoppybutthole";
  email = "";
  name = "Mr Poppy Butthole";
in
{
  imports = [
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
  ] ++ [
    (lib.mkIf (config.services.xserver.enable) (import ../services/x/xmonad.nix (args // { user = user; })))
    (lib.mkIf (config.services.xserver.enable) (import ../packages/firefox.nix (args // { user = user; })))
  ];

  users.users = {
    root = {
      initialHashedPassword = lib.mkForce "";
    };

    ${user} = {
      initialHashedPassword = "";
    };
  };

  home-manager = {
    users.${user} = {
      home.file."Wallpapers/Season-01-Gas-station-by-dutchtide.png".source = ../assets/wallpapers/Season-01-Gas-station-by-dutchtide.png;
    };
  };

  services.getty.autologinUser = lib.mkForce user;
  services.getty.greetingLine = lib.mkForce ''\l'';
}
