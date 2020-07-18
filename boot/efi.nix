{ lib, pkgs, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      version = 2;
      backgroundColor = "#21202D";
      configurationLimit = 30;

      extraConfig = ''
        set menu_color_normal=light-blue/black
        set menu_color_highlight=black/light-blue
      '';
      splashMode = "normal";
      splashImage = lib.mkDefault null;
    };
  };

}
