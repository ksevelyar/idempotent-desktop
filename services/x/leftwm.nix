{ user, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs;
    [
      libnotify
      dunst
      xcape
      lxqt.lxqt-policykit
      xfce.xfce4-settings # xfce4-mime-settings
    ];

  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    windowManager.leftwm.enable = true;
  };

  home-manager = {
    users.${user} = {
      home.file.".config/leftwm/config.toml".source = lib.mkDefault ../../users/shared/leftwm/config.toml;
      home.file.".config/leftwm/themes/current/up".source = lib.mkDefault ../../users/shared/leftwm/themes/wide-polybar/up;
      home.file.".config/leftwm/themes/current/down".source = lib.mkDefault ../../users/shared/leftwm/themes/wide-polybar/down;
      home.file.".config/leftwm/themes/current/change_to_tag".source = ../../users/shared/leftwm/themes/wide-polybar/change_to_tag;
      home.file.".config/leftwm/themes/current/template.liquid".source = lib.mkDefault ../../users/shared/leftwm/themes/wide-polybar/template.liquid;
      home.file.".config/leftwm/themes/current/theme.toml".source = lib.mkDefault ../../users/shared/leftwm/themes/wide-polybar/theme.toml;

      home.file.".config/rofi/grey.rasi".source = ../../users/shared/rofi/grey.rasi;
      home.file.".config/rofi/config.rasi".source = lib.mkDefault ../../users/shared/rofi/config.rasi;
      home.file.".config/rofimoji.rc".source = lib.mkDefault ../../users/shared/rofi/rofimoji.rc;

      home.file.".xxkbrc".source = ../../users/shared/.xxkbrc;

      home.file.".config/dunst/dunstrc".source = lib.mkDefault ../../users/shared/dunst/dunstrc;
    };
  };
}
