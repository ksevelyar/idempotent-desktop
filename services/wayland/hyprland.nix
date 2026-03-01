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
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];
  xdg.portal.config = {
    hyprland = {
      default = ["hyprland"];
    };
  };

  programs.hyprland = {
    enable = true;
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt6ct";
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
