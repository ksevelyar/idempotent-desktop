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
    windowManager.leftwm.enable = true;
  };

  home-manager = {
    users.${user} = {
      home.file.".config/leftwm/config.toml".source = ../../users/shared/.config/leftwm/config.toml;
      home.file.".config/leftwm/themes/current/up".source = ../../users/shared/.config/leftwm/themes/wide-polybar/up;
      home.file.".config/leftwm/themes/current/change_to_tag".source = ../../users/shared/.config/leftwm/themes/wide-polybar/change_to_tag;
      home.file.".config/leftwm/themes/current/template.liquid".source = ../../users/shared/.config/leftwm/themes/wide-polybar/template.liquid;
      home.file.".config/leftwm/themes/current/down".source = ../../users/shared/.config/leftwm/themes/wide-polybar/down;
      home.file.".config/leftwm/themes/current/theme.toml".source = ../../users/shared/.config/leftwm/themes/wide-polybar/theme.toml;

      home.file.".fehbg".text = lib.mkDefault ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/wallpapers/
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
