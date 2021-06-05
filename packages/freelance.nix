{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # hubstaff
      masterpdfeditor4
      upwork
      # skype
      # teams
    ];
}
