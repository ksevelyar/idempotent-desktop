{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      jack_capture
      qjackctl

      soundfont-fluid
      fluidsynth
      helm
      zynaddsubfx
    ];

  services.jack = {
    jackd = {
      enable = false;
      # To obtain a valid device argument run `aplay -l`
      #     - `hw` prefix should be always there
      #     - `1` is a card number
      #     - `0` is a device number
      # Example (card 1, device 0)
      # card 1: USB [Scarlett 2i2 USB], device 0: USB Audio [USB Audio]
      #   Subdevices: 0/1
      #   Subdevice #0: subdevice #0
      # extraOptions = [ "-dalsa" "--device" "hw:2,0" ];
      package = pkgs.jack2Full;
    };
  };
}
