{ lib, ... }:
{
  services.picom = {
    enable = lib.mkDefault true;
    fade = lib.mkDefault true;
    fadeDelta = lib.mkDefault 5;
    shadow = lib.mkDefault false;
    backend = lib.mkDefault "glx";
    vSync = true;
  };
}
