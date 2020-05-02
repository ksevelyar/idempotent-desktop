{ config, pkgs, lib, ... }:
{
  hardware = {
    pulseaudio.enable = true;
  };
  sound.enable = true;
}
