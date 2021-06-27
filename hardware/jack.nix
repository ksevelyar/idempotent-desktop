{ config, pkgs, lib, output, ... }:
{
  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      jack_capture
      qjackctl

      soundfont-fluid
      fluidsynth
      helm
      vcv-rack
      zynaddsubfx

      rosegarden
    ];

  services.jack = {
    jackd = {
      enable = true;
      # To obtain a valid output device argument run `aplay -l`
      #     - `hw` prefix should be always there
      #     - `1` is a card number
      #     - `0` is a device number

      # Example: hw:0,0
      extraOptions = [ "-dalsa" "--device" output ];
      package = pkgs.jack2Full;
    };
  };
}
