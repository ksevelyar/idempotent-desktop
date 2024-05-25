args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "obstinatekate";
  email = "obstinatekate@gmail.com";
  name = "obstinatekate";
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
}
