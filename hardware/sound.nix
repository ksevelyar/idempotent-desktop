{ config, pkgs, lib, ... }:
{
  sound.enable = true;

  hardware = {
    # pa-info to debug
    # pacmd list-sinks | grep -e 'name:' -e 'index:'
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull; # JACK support, Bluetooth
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      # auto-switch to bluetooth headset
      extraConfig = lib.mkDefault "load-module module-switch-on-connect";
    };
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      pavucontrol
      pamixer
    ];
}
