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
        obconf
      ];

  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  console.useXkbConfig = true;

  # services.xserver.desktopManager.lxqt.enable = true;
  services.xserver = {
    windowManager = {
      openbox.enable = true;
    };
  };
}
