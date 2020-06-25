{ config, pkgs, ... }:
{
  vars.user = "obstinatekate";

  home-manager = {
    users.obstinatekate = {
      programs.git = {
        enable = true;
        userName = "Ekaterina Lobanova";
        userEmail = "obstinatekate@gmail.com";
      };
    };
  };
}
