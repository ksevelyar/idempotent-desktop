args@{ config, pkgs, lib, ... }:
let
  user = "ksevelyar";
  email = "ksevelyar@gmail.com";
  name = "Sergey Zubkov";
in
{
  imports = [
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
  ] ++ [
    (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // { user = user; })))
    (lib.mkIf (config.services.xserver.enable) (import ../services/x/leftwm.nix (args // { user = user; })))
    (lib.mkIf (config.services.xserver.enable) (import ../packages/firefox.nix (args // { user = user; })))
  ];

  networking.extraHosts =
    ''
      127.0.0.1 dev.lcl
    '';

  systemd.tmpfiles.rules =
    [
      "d /vvv 0700 ${user} wheel" # secrets
    ];
}
