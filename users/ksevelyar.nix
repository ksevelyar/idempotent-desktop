{ config, pkgs, lib, vars, ... }:
let
  user = "ksevelyar";
  email = "ksevelyar@gmail.com";
  name = "Sergey Zubkov";
in
{
  imports = [
    (
      import ./shared.nix (
        {
          pkgs = pkgs;
          lib = lib;
          user = user;
          email = email;
          name = name;
        }
      )
    )
  ];


  users.users.${user} = {
    description = name;
  };

  # dev hosts
  networking.extraHosts =
    ''
      127.0.0.1 dev.lcl
    '';

  systemd.tmpfiles.rules =
    [
      "d /vvv 0700 1000 wheel" # secrets
      "d /c 0744 1000 wheel" # code
      "d /com 0744 1000 wheel" # code
    ];

  home-manager = {
    users.${user} = {


      home.file.".mbsyncrc".source = ./ksevelyar/.mbsyncrc;
      home.file.".notmuch-config".source = ./ksevelyar/.notmuch-config;
      home.file.".config/msmtp/msmtp/config".source = ./ksevelyar/.config/msmtp/config;
      home.file."Wallpapers/Season-01-Gas-station-by-dutchtide.png".source = ../assets/wallpapers/Season-01-Gas-station-by-dutchtide.png;
    };
  };
}
