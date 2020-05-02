{ config, pkgs, lib, ... }:
{
  hardware = {
    bluetooth.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
  };
}
