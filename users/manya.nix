args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "manya";
  email = "porosenie@gmail.com";
  name = "Maria Elizarova";
in {
  time.timeZone = lib.mkForce "Asia/Tbilisi";
  imports = [
    (import ./shared.nix (args
      // {
        user = user;
        email = email;
        name = name;
      }))
    (import ../packages/firefox.nix (args // {user = user;}))
  ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/wallpapers/planet.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";
}
