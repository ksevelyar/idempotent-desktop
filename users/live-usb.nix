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
    (import ../services/x/xmonad.nix (args // { user = user; }))
    (import ../packages/firefox.nix (args // { user = user; }))
  ];

  users.users = {
    root = {
      # id, to generate hashed password run mkpasswd -m sha-512
      initialHashedPassword = lib.mkForce "$6$zKk1qNy.84$mVGFT2YYt39K2NI17T7skDyyVXf8LVMG.7vF.JMrKqTq6INet9eLj8BUeLR.QAKdU2cyGELQ04UP6GFIG4LX./";
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
