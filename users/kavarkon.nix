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

  networking.extraHosts = ''
    127.0.0.1 dev.lcl
  '';

  age.identityPaths = ["/home/kavarkon/.ssh/id_ed25519"];

  age.secrets.kavarkon-xray-json = {
    file = ../secrets/kavarkon/xray-xhttp.kavarkon.age;
    owner = "xray";
    group = "xray";
  };

  systemd.services.xray.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "xray";
  };
  users.users.xray = {
    isSystemUser = true;
    group = "xray";
  };
  users.groups.xray = {};
}
