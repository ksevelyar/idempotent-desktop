{
  config,
  pkgs,
  ...
}: {
  # NOTE: use gtk file dialogs in qt apps like telegram
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
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
    GDK_SCALE = "1";              # Let Wayland handle physical scaling
    GDK_DPI_SCALE = "1";          # Disable double-scaling
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.hyprland = {
    enable = true;
  };

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
      # kvantum
      libsForQt5.qtstyleplugin-kvantum

      sunsetr
      hyprlock
      hypridle
      wpaperd
      hyprpicker
      rofi
      waybar
      grim
      slurp

      waybar-weather
    ];
}
