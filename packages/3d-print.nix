# https://www.thingiverse.com/ksevelyar/likes
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # slicers
      slic3r-prusa3d
      stable.cura

      # programmatic cads
      openscad
      libfive
    ];
}
