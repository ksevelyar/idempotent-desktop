args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "kh";
  email = "ts.khol@gmail.com";
  name = "Tatiana Kh";
in {
  imports = [
    (import ./shared.nix (args
      // {
        user = user;
        email = email;
        name = name;
      }))
    (import ../packages/firefox.nix (args // {user = user;}))
  ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/season-01-gas-station-by-dutchtide.png".source = ../assets/wallpapers/season-01-gas-station-by-dutchtide.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl market.lcl
  '';

  age.secrets.kh-xray-json = {
    file = ../secrets/kh/xray-xhttp.age;
  };
}
