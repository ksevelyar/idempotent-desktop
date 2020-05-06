{ lib, ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelParams = [ "quiet" ];
  # boot.consoleLogLevel = 3;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      version = 2;
      backgroundColor = "#35246e";
      memtest86.enable = true;
      configurationLimit = 42;

      # extraConfig = "set theme=($drive1)//grub/themes/fallout-grub-theme/theme.txt";
      splashImage = ../../assets/grub.png;
      splashMode = "normal";
      font = ../../assets/ter-u16n.pf2;
      extraConfig = ''
        set menu_color_normal=light-blue/black
        set menu_color_highlight=black/light-blue
      '';
    };
  };
}
