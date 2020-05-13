{ config, pkgs, ... }:
{
  imports =
    [
      ./ksevelyar-headless.nix
    ];

  # dev hosts
  networking.extraHosts =
    ''
      127.0.0.1 l.lcl
    '';

  home-manager = {
    users.ksevelyar = {
      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = ../home/.xmonad/xmonad.hs;

      home.file."Wallpapers/1.png".source = ../home/wallpapers/1.png;

      home.file.".xxkbrc".source = ../home/.xxkbrc;
      home.file.".Xresources".source = ../home/.Xresources;

      home.file.".config/dunst/dunstrc".source = ../home/.config/dunst/dunstrc;

      home.file.".config/conky/conky-taskwarrior.conf".source = ../home/.config/conky/conky-taskwarrior.conf;
      home.file.".config/conky/conky-lyrics.conf".source = ../home/.config/conky/conky-lyrics.conf;
      home.file.".config/conky/launch.sh".source = ../home/.config/conky/launch.sh;

      home.file.".config/polybar/launch.sh".source = ../home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = ../home/.config/polybar/config;
      home.file.".config/polybar/gpmdp-next.sh".source =
        ../home/.config/polybar/gpmdp-next.sh;
      home.file.".config/polybar/gpmdp-rewind.sh".source =
        ../home/.config/polybar/gpmdp-rewind.sh;
      home.file.".config/polybar/gpmdp.sh".source = ../home/.config/polybar/gpmdp.sh;
      home.file.".config/polybar/weather.sh".source = ../home/.config/polybar/weather.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../home/.config/polybar/local_and_public_ips.sh;

      home.file.".config/rofi/joker.rasi".source = ../home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = ../home/.config/rofi/config.rasi;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source =
        ../home/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source =
        ../home/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source =
        ../home/.config/roxterm.sourceforge.net/Global;

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../home/.config/alacritty/alacritty-scratchpad.yml;

      home.file.".config/mpv/mpv.conf".source = ../home/.config/mpv/mpv.conf;

      home.file.".icons/default/index.theme".text = ''
        [Icon Theme]
        Name=Default
        Comment=Default Cursor Theme
        Inherits=Vanilla-DMZ
      '';
      home.file.".local/share/fonts/ter-u14n.otb".source = ../assets/fonts/ter-u14n.otb;

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/Wallpapers/
      '';

      home.file.".ssh/config".source = ../home/.ssh/config;
    };
  };
}
