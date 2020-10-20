{ config, pkgs, lib, vars, ... }:
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        twmn
        polybar
        jgmenu
        xcape

        lxqt.lxqt-policykit
        libnotify
        dunst
        xfce.xfce4-settings # xfce4-mime-settings
      ];

  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    displayManager = {
      defaultSession = lib.mkDefault "none+xmonad";
    };

    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  };

  home-manager = {
    users.${vars.user} = {
      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = lib.mkDefault ../../users/shared/.xmonad/xmonad.hs;

      home.file.".fehbg".text = lib.mkDefault ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/Wallpapers/
      '';

      home.file.".config/rofi/joker.rasi".source = ../../users/shared/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = ../../users/shared/.config/rofi/config.rasi;

      home.file.".config/jgmenu/jgmenurc".source = ../../users/shared/.config/jgmenu/jgmenurc;

      home.file.".xxkbrc".source = ../../users/shared/.xxkbrc;

      home.file.".config/conky/conky-taskwarrior.conf".source = ../../users/shared/.config/conky/conky-taskwarrior.conf;
      home.file.".config/conky/conky-lyrics.conf".source = ../../users/shared/.config/conky/conky-lyrics.conf;
      home.file.".config/conky/launch.sh".source = ../../users/shared/.config/conky/launch.sh;

      home.file.".config/dunst/dunstrc".source = ../../users/shared/.config/dunst/dunstrc;
      home.file.".config/twmn/twmn.conf".source = ../../users/shared/.config/twmn/twmn.conf;

      home.file.".config/polybar/launch.sh".source = lib.mkDefault ../../users/shared/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = ../../users/shared/.config/polybar/config;
      home.file.".config/polybar/gpmdp.sh".source = ../../users/shared/.config/polybar/gpmdp.sh;
      home.file.".config/polybar/spotify.sh".source = ../../users/shared/.config/polybar/spotify.sh;
      home.file.".config/polybar/weather.sh".source = ../../users/shared/.config/polybar/weather.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../../users/shared/.config/polybar/local_and_public_ips.sh;
    };
  };
}
