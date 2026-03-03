{
  config,
  pkgs,
  lib,
  ...
}: {
  services.speechd.enable = false;
  services.displayManager = {
    defaultSession = "hyprland";
    ly = {
      enable = true;
      settings = {
        hide_version_string = true;
        hide_key_hints = true;
      };
    };
  };

  # xdg

  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
  };

  programs.hyprland = {
    enable = true;
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = let
    waybar-weather = pkgs.rustPlatform.buildRustPackage {
      pname = "waybar-weather";
      version = "0.1.0";
      src = pkgs.lib.cleanSource ../../services/wayland/waybar-weather;
      cargoLock = {
        lockFile = ../../services/wayland/waybar-weather/Cargo.lock;
      };
      doCheck = false;

      env = {
        LATITUDE = toString config.location.latitude;
        LONGITUDE = toString config.location.longitude;
      };
    };
  in
    with pkgs; [
      vanilla-dmz
      dracula-theme
      dracula-icon-theme

      hyprlock
      hypridle
      hyprpaper
      hyprpicker
      rofi
      wofi
      waybar
      grim
      slurp

      cliphist
      wl-clipboard

      waybar-weather
    ];
}
