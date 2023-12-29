{ config, pkgs, lib, ... }:
let
  sound-volume-up = pkgs.writeScriptBin "sound-volume-up" ''
    #!${pkgs.stdenv.shell}
    set -e

    pactl set-sink-volume @DEFAULT_SINK@ +2%
    notify-send -h string:synchronous:volume "$(pamixer --get-volume-human)" -t 1000
  '';

  sound-volume-down = pkgs.writeScriptBin "sound-volume-down" ''
    #!${pkgs.stdenv.shell}
    set -e

    pactl set-sink-volume @DEFAULT_SINK@ -2%
    notify-send -h string:synchronous:volume "$(pamixer --get-volume-human)" -t 1000
  '';
in
{
  environment.systemPackages = lib.mkIf config.services.xserver.enable [
    sound-volume-up
    sound-volume-down
    pkgs.pavucontrol
    pkgs.pamixer
    pkgs.pulseaudio # pactl
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
