{ lib, ... }:
{
  services.redshift = {
    enable = true;
    temperature.night = 4000;
    temperature.day = 6500;
  };
}
