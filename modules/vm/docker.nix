{ vars, pkgs, lib, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = lib.mkDefault false;
  };

  users.users.${vars.user}.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
