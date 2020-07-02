{ config, pkgs, lib, vars, ... }:
{
  vars.user = "ksevelyar";
  vars.email = "ksevelyar@gmail.com";

  users.users.${vars.user} = {
    description = "Sergey Zubkov";
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
    ];

  home-manager = {
    users.${vars.user} = {
      programs.git = {
        userName = "Sergey Zubkov";
        userEmail = vars.email;
      };

      home.file.".mbsyncrc".source = ./ksevelyar/.mbsyncrc;
      home.file.".notmuch-config".source = ./ksevelyar/.notmuch-config;
      home.file.".config/msmtp/msmtp/config".source = ./ksevelyar/.config/msmtp/config;
      home.file."Wallpapers/Season-01-Gas-station-by-dutchtide.png".source = ../assets/wallpapers/Season-01-Gas-station-by-dutchtide.png;
    };
  };

  services.xserver = {
    displayManager = {
      sessionCommands = ''
        sh ~/.config/conky/launch.sh
      '';
    };
  };
}
