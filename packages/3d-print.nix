# https://www.thingiverse.com/ksevelyar/likes
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # slicers
      slic3r-prusa3d
      cura

      # programmatic cads
      openscad
      libfive
    ];
}
