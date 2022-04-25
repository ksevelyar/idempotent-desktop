{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      gimp
      inkscape
    ];
}
