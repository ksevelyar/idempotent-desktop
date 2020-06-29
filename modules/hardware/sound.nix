{ config, pkgs, lib, ... }:
{
  sound.enable = true;

  hardware = {
    # pa-info to debug
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull; # JACK support, Bluetooth
      extraModules = [ pkgs.pulseaudio-modules-bt ];

      # auto-switch to bluetooth headset, disable auto-switch to hdmi sound
      configFile = ../../home/default.pa;
    };
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      pavucontrol
    ];
}
