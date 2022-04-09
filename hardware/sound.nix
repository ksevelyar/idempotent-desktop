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

  environment.shellAliases = {
    sound-volume-up = ''
      pactl set-sink-volume @DEFAULT_SINK@ +2% && notify-send -h string:synchronous:volume "$(pamixer --get-volume-human)" -t 1000
    '';
    sound-volume-down = ''
      pactl set-sink-volume @DEFAULT_SINK@ -2% && notify-send -h string:synchronous:volume "$(pamixer --get-volume-human)" -t 1000
    '';
  };
}
