{ config, pkgs, lib, ... }:
{
  sound.enable = true;

  hardware = {
    # pa-info to debug
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull; # JACK support, Bluetooth
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      extraConfig = "load-module module-switch-on-connect"; # auto-switch to bluetooth headset
    };
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      pavucontrol
    ];
}
