{ pkgs, lib, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      antialias = false;
      hinting.enable = false;
    };
  };

  console = {
    font = "Lat2-Terminus32";
  };
}
