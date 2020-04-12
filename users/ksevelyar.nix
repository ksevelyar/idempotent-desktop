{ config, pkgs, ... }:
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  location.latitude = 55.75;
  location.longitude = 37.61;

  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant-Dracula
        gtk-icon-theme-name=Paper-Mono-Dark
        gtk-font-name=Anka/Coder 13
        # gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        inode/directory=spacefm.desktop

        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/ftp=firefox.desktop
        x-scheme-handler/chrome=firefox.desktop
        text/html=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
      '';
    };

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ksevelyar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    useGlobalPkgs = true;

    users.ksevelyar = {
      programs.git = {
        enable = true;
        userName = "Sergey Zubkov";
        userEmail = "ksevelyar@gmail.com";
      };

      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = /etc/nixos/home/.xmonad/xmonad.hs;

      home.file."Wallpapers/1.png".source = /etc/nixos/home/wallpapers/1.png;

      home.file.".config/polybar/launch.sh".source = /etc/nixos/home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = /etc/nixos/home/.config/polybar/config;
      home.file.".config/polybar/gpmdp-next.sh".source = /etc/nixos/home/.config/polybar/gpmdp-next.sh;
      home.file.".config/polybar/gpmdp-rewind.sh".source = /etc/nixos/home/.config/polybar/gpmdp-rewind.sh;
      home.file.".config/polybar/gpmdp.sh".source = /etc/nixos/home/.config/polybar/gpmdp.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source = /etc/nixos/home/.config/polybar/local_and_public_ips.sh;

      home.file.".config/rofi/joker.rasi".source = /etc/nixos/home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = /etc/nixos/home/.config/rofi/config.rasi;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source = /etc/nixos/home/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source = /etc/nixos/home/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source = /etc/nixos/home/.config/roxterm.sourceforge.net/Global;

      home.file.".config/terminator/config".source = /etc/nixos/home/.config/terminator/config;

      home.file.".config/nvim/init.vim".source = /etc/nixos/home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = /etc/nixos/home/.config/nvim/coc-settings.json;

      home.file.".icons/default/index.theme".text = ''
        [Icon Theme]
        Name=Default
        Comment=Default Cursor Theme
        Inherits=Vanilla-DMZ
      '';

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/Wallpapers/
      '';

      home.file.".ssh/config".text = ''
        Host *
          ForwardAgent yes

        Host 192.168.0.*
          StrictHostKeyChecking no
          UserKnownHostsFile=/dev/null
      '';
    };
  };
}
