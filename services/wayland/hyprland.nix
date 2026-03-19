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

    toggle-scratchpad = pkgs.writeScriptBin "toggle-scratchpad" ''
      #!${pkgs.fish}/bin/fish
        set CLASS_NAME $argv[1]
        set LAUNCH_CMD $argv[2]
        set LAUNCH_ARGS $argv[3..-1]
        set HIDDEN_WORKSPACE "special:scratchpads"
        set CURRENT_WORKSPACE (hyprctl activeworkspace -j | jq '.id')
        set WINDOW_ADDR (hyprctl clients -j | jq -r --arg class "$CLASS_NAME" '.[] | select(.class | test("^" + $class + "$")) | .address' | head -n 1)

        if [ -z "$WINDOW_ADDR" ]
          $LAUNCH_CMD --class $CLASS_NAME $LAUNCH_ARGS &
        else
          set WINDOW_WORKSPACE (hyprctl clients -j | jq -r --arg addr "$WINDOW_ADDR" '.[] | select(.address == $addr) | .workspace.id')

          if [ "$WINDOW_WORKSPACE" = "$CURRENT_WORKSPACE" ]
            hyprctl dispatch movetoworkspacesilent "$HIDDEN_WORKSPACE,address:$WINDOW_ADDR"
          else
            hyprctl dispatch movetoworkspace "$CURRENT_WORKSPACE,address:$WINDOW_ADDR"
          end
        end
    '';
  in
    with pkgs; [
      vanilla-dmz
      dracula-theme
      dracula-icon-theme

      sunsetr
      hyprlock
      hypridle
      wpaperd
      hyprpicker
      rofi
      waybar
      grim
      slurp
      jq

      waybar-weather
      toggle-scratchpad
    ];
}
