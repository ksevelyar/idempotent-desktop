{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware = {
    bluetooth.enable = true;
  };

  services.blueman.enable = lib.mkIf (config.services.xserver.enable) true;
  programs.dconf.enable = lib.mkIf (config.services.xserver.enable) true;
}
