{ config, pkgs, ... }:
{
  imports =
    [
      ./shared.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/kh";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-kh.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  home-manager = {
    users.kh = {
      programs.git = {
        enable = true;
        userName = "Tatiana Kh";
        userEmail = "ts.khol@gmail.com";
        aliases = {
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
          recent-branches = "branch --sort=-committerdate";
        };
      };

      # TODO: create module for Terminus
      home.file.".local/share/fonts/ter-u12n.otb".source = ../assets/fonts/ter-u12n.otb;
      home.file.".local/share/fonts/ter-u12b.otb".source = ../assets/fonts/ter-u12b.otb;
      home.file.".local/share/fonts/ter-u14n.otb".source = ../assets/fonts/ter-u14n.otb;
      home.file.".local/share/fonts/ter-u14b.otb".source = ../assets/fonts/ter-u14b.otb;
      home.file.".local/share/fonts/ter-u16n.otb".source = ../assets/fonts/ter-u16n.otb;
      home.file.".local/share/fonts/ter-u16b.otb".source = ../assets/fonts/ter-u16b.otb;
      home.file.".local/share/fonts/ter-u18n.otb".source = ../assets/fonts/ter-u18n.otb;
      home.file.".local/share/fonts/ter-u18b.otb".source = ../assets/fonts/ter-u18b.otb;
      home.file.".local/share/fonts/ter-u20n.otb".source = ../assets/fonts/ter-u20b.otb;
      home.file.".local/share/fonts/ter-u20b.otb".source = ../assets/fonts/ter-u20b.otb;
      home.file.".local/share/fonts/ter-u22n.otb".source = ../assets/fonts/ter-u22b.otb;
      home.file.".local/share/fonts/ter-u22b.otb".source = ../assets/fonts/ter-u22b.otb;
      home.file.".local/share/fonts/ter-u24n.otb".source = ../assets/fonts/ter-u24b.otb;
      home.file.".local/share/fonts/ter-u24b.otb".source = ../assets/fonts/ter-u24b.otb;
      home.file.".local/share/fonts/ter-u28n.otb".source = ../assets/fonts/ter-u28b.otb;
      home.file.".local/share/fonts/ter-u28b.otb".source = ../assets/fonts/ter-u28b.otb;
      home.file.".local/share/fonts/ter-u32n.otb".source = ../assets/fonts/ter-u32b.otb;
      home.file.".local/share/fonts/ter-u32b.otb".source = ../assets/fonts/ter-u32b.otb;

      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = ../home/.xmonad/xmonad.hs;

      home.file."Wallpapers/1.png".source = ../home/wallpapers/1.png;

      home.file.".xxkbrc".source = ../home/.xxkbrc;
      home.file.".eslintrc.json".source = ../home/.eslintrc.json;
      home.file.".npmrc".source = ../home/.npmrc;

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
      home.file.".config/polybar/local_and_public_ips.sh".source =
        ../home/.config/polybar/local_and_public_ips.sh;

      home.file.".config/rofi/joker.rasi".source = ../home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = ../home/.config/rofi/config.rasi;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source =
        ../home/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source =
        ../home/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source =
        ../home/.config/roxterm.sourceforge.net/Global;


      # home.file.".config/nvim/init.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../home/.config/nvim/coc-settings.json;

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../home/.config/alacritty/alacritty-scratchpad.yml;


      home.file.".config/mpv/mpv.conf".source = ../home/.config/mpv/mpv.conf;


      home.file.".config/fish/config.fish".source = ../home/.config/fish/config.fish;
      home.file.".config/fish/functions/git_aliases.fish".source = ../home/.config/fish/functions/git_aliases.fish;
      home.file.".config/fish/conf.d/z.fish".source = ../home/.config/fish/conf.d/z.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../home/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../home/.config/fish/functions/fish_print_git_action.fish;

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
    };
  };
}
