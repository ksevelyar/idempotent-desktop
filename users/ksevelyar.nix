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

  home-manager = {
    users.ksevelyar = {
      programs.git = {
        userName = "Sergey Zubkov";
        userEmail = "ksevelyar@gmail.com";
      };
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
