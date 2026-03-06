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
      (import ../packages/firefox.nix (args // {user = user;}))
    ];

  networking.extraHosts = ''
    127.0.0.1 dev.lcl
  '';

  age.secrets.kavarkon-xray-json = {
    file = ../secrets/kavarkon/xray-xhttp.age;
  };

  home-manager = {
    users.${user} = {
      xdg.desktopEntries = {
        "discord-canary-proxy" = {
          name = "Discord Canary (Proxy)";
          exec = "discordcanary --proxy-server=\"socks5://127.0.0.1:2081\" %U";
          terminal = false;
          icon = "discord-canary";
          categories = ["Network" "InstantMessaging" "Chat"];
          mimeType = [
            "x-scheme-handler/discord"
          ];
        };
      };
    };
  };
}
