# sudo udevadm hwdb --update
{ config, pkgs, lib, ... }:
{
  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      extraConfig = "load-module module-switch-on-connect";
    };
  };
  services.blueman.enable = true;
}
