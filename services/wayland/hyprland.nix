{
  user,
  pkgs,
  lib,
  ...
}: {
  services.xserver.enable = false;

  programs = {
    hyprland.enable = true; # enable Hyprland
  };

  environment.systemPackages = with pkgs; [
    waybar
    kitty
    # mako
    # wofi
  ];

  home-manager = {
    users.${user} = {
      home.file.".config/hypr/hyprland.conf".text = ''
        # General configuration
        workspace {
          name = "default"
          layout = "tiling"
        }

        # Example to set up a basic bar
        bar {
          position = top
          height = 30
          font_size = 14
          color = "#ffffff"
        }

        # Example to set Alacritty as the default terminal
        exec_always = alacritty
      '';
    };
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
