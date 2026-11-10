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
  ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/season-01-gas-station-by-dutchtide.png".source = ../assets/wallpapers/season-01-gas-station-by-dutchtide.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl market.lcl
  '';

  age.identityPaths = [
    "/home/${user}/.ssh/id_ed25519"
    "/home/${user}/.ssh/id_rsa"
    "/etc/ssh/ssh_host_ed25519_key"
  ];
  age.secrets.kh-xray-json = {
    file = ../secrets/kh/xray-xhttp.age;
  };
}
