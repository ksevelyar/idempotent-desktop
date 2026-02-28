args @ {
  config,
  pkgs,
  lib,
  ...
}: let
  user = "ksevelyar";
  email = "ksevelyar@protonmail.com";
  name = "Sergey Zubkov";
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
      (lib.mkIf (config.programs.hyprland.enable) (import ../packages/firefox.nix (args // {user = user;})))
    ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/2b.png".source = ../assets/wallpapers/2b.png;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl habits.lcl market.lcl buzz.lcl
  '';

  age.identityPaths = ["/home/ksevelyar/.ssh/id_ed25519"];
  age.secrets.wg-hk47.file = ../secrets/ksevelyar/wg-hk47.age;
  age.secrets.wg-laundry.file = ../secrets/ksevelyar/wg-laundry.age;
  age.secrets.ksevelyar-xray-json.file = ../secrets/ksevelyar/xray-xhttp.age;
}
