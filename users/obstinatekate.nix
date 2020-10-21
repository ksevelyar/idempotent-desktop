{ config, pkgs, vars, ... }:
{
  vars.user = "obstinatekate";
  vars.email = "obstinatekate@gmail.com";
  vars.name = "obstinatekate";

  users.users.${vars.user} = {
    description = vars.name;
  };
}
