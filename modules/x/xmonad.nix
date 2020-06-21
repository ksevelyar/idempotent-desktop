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

  # polybar integration
  systemd.tmpfiles.rules =
    [
      "p+ /tmp/.xmonad-workspace-log 0600 1000 users"
    ];

  home-manager = {
    users.${vars.user} = {
      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = lib.mkDefault ../../home/.xmonad/xmonad.hs;

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/Wallpapers/
      '';

      home.file.".config/rofi/joker.rasi".source = ../../home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = ../../home/.config/rofi/config.rasi;

      home.file.".config/jgmenu/jgmenurc".source = ../../home/.config/jgmenu/jgmenurc;

      home.file.".xxkbrc".source = ../../home/.xxkbrc;

      home.file.".config/conky/conky-taskwarrior.conf".source = ../../home/.config/conky/conky-taskwarrior.conf;
      home.file.".config/conky/conky-lyrics.conf".source = ../../home/.config/conky/conky-lyrics.conf;
      home.file.".config/conky/launch.sh".source = ../../home/.config/conky/launch.sh;

      home.file.".config/dunst/dunstrc".source = ../../home/.config/dunst/dunstrc;
      home.file.".config/twmn/twmn.conf".source = ../../home/.config/twmn/twmn.conf;

      home.file.".config/polybar/launch.sh".source = ../../home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = ../../home/.config/polybar/config;
      home.file.".config/polybar/gpmdp.sh".source = ../../home/.config/polybar/gpmdp.sh;
      home.file.".config/polybar/spotify.sh".source = ../../home/.config/polybar/spotify.sh;
      home.file.".config/polybar/weather.sh".source = ../../home/.config/polybar/weather.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../../home/.config/polybar/local_and_public_ips.sh;
    };
  };
}
