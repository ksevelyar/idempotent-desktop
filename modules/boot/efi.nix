{ lib, ... }:
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
      memtest86.enable = true;
      configurationLimit = 30;

      extraConfig = ''
        set menu_color_normal=light-blue/black
        set menu_color_highlight=black/light-blue
      '';
      splashMode = "normal";
      splashImage = null;

      # Add to your host to change defaults:
      # font = ../../assets/fonts/ter-u16n.pf2;
      # splashImage = ../../assets/grub.png;
      # extraConfig = "set theme=($drive1)//grub/themes/fallout-grub-theme/theme.txt";
    };
  };
}
