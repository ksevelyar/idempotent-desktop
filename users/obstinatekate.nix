args@{ config, pkgs, lib, ... }:
let
  user = "obstinatekate";
  email = "obstinatekate@gmail.com";
  name = "obstinatekate";
in
{
  imports = [
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
    (import ../services/x/xmonad.nix (args // { user = user; }))
    (import ../packages/firefox.nix (args // { user = user; }))
  ];
}
