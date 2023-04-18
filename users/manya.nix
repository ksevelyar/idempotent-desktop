args@{ config, pkgs, lib, ... }:
let
  user = "manya";
  email = "porosenie@gmail.com";
  name = "Maria Elizarova";
in
{
  time.timeZone = lib.mkForce "Asia/Tbilisi";
  imports = [
    (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // { user = user; })))
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
    (import ../services/x/leftwm.nix (args // { user = user; }))
    (import ../packages/firefox.nix (args // { user = user; }))
  ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/wallpapers/planet.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  home-manager = {
    users.manya = {
      home.file.".config/leftwm/config.toml".source = ../users/manya/leftwm/config.toml;
      home.file.".config/leftwm/themes/current/template.liquid".source = ../users/manya/leftwm/template.liquid;
      home.file.".config/polybar/config".source = lib.mkForce ../users/manya/polybar/config;
    };
  };
}
