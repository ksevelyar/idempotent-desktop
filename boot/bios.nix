{ lib, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };
    grub = {
      enable = true;
      efiSupport = false;
      device = lib.mkDefault "/dev/sda"; # MBR/BIOS

      version = 2;
      backgroundColor = "#21202D";
      configurationLimit = 30;

      extraConfig = ''
        set menu_color_normal=light-blue/black
        set menu_color_highlight=black/light-blue
      '';
      splashMode = lib.mkDefault "normal";
      splashImage = lib.mkDefault null;
    };
  };
}
