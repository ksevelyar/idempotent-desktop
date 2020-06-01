{ config, pkgs, ... }:
{
  vars.user = "obstinatekate";

  home-manager = {
    users.obstinatekate = {
      programs.git = {
        enable = true;
        userName = "Ekaterina Lobanova";
        userEmail = "obstinatekate@gmail.com";
        aliases.lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
  };
}
