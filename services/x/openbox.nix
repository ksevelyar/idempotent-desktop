{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        polybar
        xlsfonts
        xcape

        libnotify
        dunst

        openbox-menu
        jgmenu
        obconf
      ];

  console.useXkbConfig = true;

  # services.xserver.desktopManager.lxqt.enable = true;
  services.xserver = {
    windowManager = {
      openbox.enable = true;
    };
  };
}
