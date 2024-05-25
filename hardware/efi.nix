{
  lib,
  pkgs,
  ...
}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      backgroundColor = "#21202D";
      configurationLimit = lib.mkDefault 30;

      extraConfig = ''
        set menu_color_normal=light-blue/black
        set menu_color_highlight=black/light-blue
      '';
      splashMode = lib.mkDefault "normal";
      splashImage = lib.mkDefault null;
    };
  };
}
