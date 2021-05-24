{ vars, pkgs, lib, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = lib.mkDefault false;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
