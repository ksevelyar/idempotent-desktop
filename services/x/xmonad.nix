{ user, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs;
    [
      twmn
      jgmenu
      xcape

      lxqt.lxqt-policykit
      libnotify
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
    users.${user} = {
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

      home.file.".config/dunst/dunstrc".source = ../../users/shared/.config/dunst/dunstrc;
      home.file.".config/twmn/twmn.conf".source = ../../users/shared/.config/twmn/twmn.conf;
    };
  };
}
