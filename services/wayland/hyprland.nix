{
  config,
  pkgs,
  lib,
  ...
}: {
  services.speechd.enable = false;
  services.displayManager.ly.enable = true;

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

  environment.systemPackages = with pkgs; [
    vanilla-dmz
    dracula-theme
    dracula-icon-theme
    # papirus-maia-icon-theme

    hyprlock
    hyprpaper
    hyprpicker
    rofi
    wofi
    waybar
    alacritty
    foot
    firefox
    grim
    slurp

    cliphist
    wl-clipboard

    brightnessctl
  ];
}
