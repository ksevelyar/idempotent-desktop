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
      (args.inputs.pi.nixosModules.forUser user)
      (import ./shared.nix (args
        // {
          user = user;
          email = email;
          name = name;
        }))
    ]
    ++ [
      (import ../packages/firefox.nix (args // {user = user;}))
    ];

  home-manager = {
    users.${user} = {
      home.file."wallpapers/johnny.jpg".source = ../assets/wallpapers/johnny.jpg;
    };
  };

  networking.extraHosts = ''
    127.0.0.1 dev.lcl habits.lcl market.lcl buzz.lcl bs.local fr.local clinic.local api.localhost
  '';

  age.secrets.wg-hk47.file = ../secrets/ksevelyar/wg-hk47.age;
  age.secrets.wg-laundry.file = ../secrets/ksevelyar/wg-laundry.age;
  age.secrets.ksevelyar-xray-json.file = ../secrets/ksevelyar/xray.age;
  age.secrets.shared-network-manager.file = ../secrets/shared/network-manager.age;
  age.secrets.ksevelyar-environment-variables = {
    file = ../secrets/ksevelyar/environment-variables.age;
    owner = user;
  };
}
