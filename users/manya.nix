{ config, pkgs, ... }:
{
  imports =
    [
      ./shared.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.manya = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/manya";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-manya.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  home-manager = {
    users.manya = {
      programs.git = {
        userName = "Maria Elizarova";
        userEmail = "porosenie@gmail.com";
      };

      home.file.".xxkbrc".source = ../home/.xxkbrc;

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
      home.file.".config/fish/config.fish".source = ../home/.config/fish/config.fish;
      home.file.".config/fish/fishfile".source = ../home/.config/fish/fishfile;
      home.file.".config/fish/functions/git_aliases.fish".source =
        ../home/.config/fish/functions/git_aliases.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source =
        ../home/.config/fish/functions/fish_prompt.fish;

      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = ../home/.xmonad/xmonad.hs;

      home.file."Wallpapers/1.png".source = ../home/wallpapers/1.png;

      home.file.".xxkbrc".source = ../home/.xxkbrc;
      home.file.".eslintrc.json".source = ../home/.eslintrc.json;
      home.file.".npmrc".source = ../home/.npmrc;

      home.file.".config/dunst/dunstrc".source = ../home/.config/dunst/dunstrc;

      home.file.".config/polybar/launch.sh".source = ../home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = ../home/.config/polybar/config;
      home.file.".config/polybar/gpmdp-next.sh".source = ../home/.config/polybar/gpmdp-next.sh;
      home.file.".config/polybar/gpmdp-rewind.sh".source = ../home/.config/polybar/gpmdp-rewind.sh;
      home.file.".config/polybar/gpmdp.sh".source = ../home/.config/polybar/gpmdp.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../home/.config/polybar/local_and_public_ips.sh;

      home.file.".config/rofi/joker.rasi".source = ../home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = ../home/.config/rofi/config.rasi;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source = ../home/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source = ../home/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source = ../home/.config/roxterm.sourceforge.net/Global;

      home.file.".config/terminator/config".source = ../home/.config/terminator/config;

      home.file.".config/nvim/init.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../home/.config/nvim/coc-settings.json;

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

      home.file.".ssh/config".source = ../home/.ssh/config;

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
