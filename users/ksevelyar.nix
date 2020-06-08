{ config, pkgs, lib, vars, ... }:
{
  vars.user = "ksevelyar";
  users.users.${vars.user} = {
    description = "Sergey Zubkov";
  };

  # dev hosts
  networking.extraHosts =
    ''
      127.0.0.1 l.lcl
      127.0.0.1 or.lcl
    '';

  systemd.tmpfiles.rules =
    [
      "d /sql 0700 1000 wheel" # sql dumps
      "d /vvv 0700 1000 wheel" # secrets
      "d /c 0744 1000 wheel" # code
    ];

  home-manager = {
    users.${vars.user} = {
      programs.git = {
        userName = "Sergey Zubkov";
        userEmail = "ksevelyar@gmail.com";
      };

      home.file.".mbsyncrc".source = ./ksevelyar/.mbsyncrc;
      home.file.".notmuch-config".source = ./ksevelyar/.notmuch-config;
      home.file.".config/msmtp/msmtp/config".source = ./ksevelyar/.config/msmtp/config;
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
