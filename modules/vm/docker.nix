{ vars, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.${vars.user}.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
