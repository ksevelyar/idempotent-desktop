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
      configurationLimit = lib.mkDefault 10;

      splashMode = lib.mkDefault "normal";
      splashImage = lib.mkDefault null;
    };
  };
}
