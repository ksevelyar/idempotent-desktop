args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "kavarkon";
  email = "fomina-ioanna@rambler.ru";
  name = "Ioanna Fomina";
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
      (lib.mkIf (config.services.xserver.enable) (import ../services/x/polybar.nix (args // {user = user;})))
      (lib.mkIf (config.services.xserver.enable) (import ../services/x/leftwm.nix (args // {user = user;})))
      (lib.mkIf (config.services.xserver.enable) (import ../packages/firefox.nix (args // {user = user;})))
    ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/2b.png".source = ../assets/wallpapers/2b.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl
  '';
}
