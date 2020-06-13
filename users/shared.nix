{ config, pkgs, vars, ... }:
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {
    uid = 1000;
    isNormalUser = true;

    # Enable ‘sudo’ for the user.
    # https://en.wikipedia.org/wiki/Wheel_(computing)
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "nginx" ];
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/${vars.user} && chown ${vars.user}:users /nix/var/nix/profiles/per-user/${vars.user}";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-${vars.user}.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  users.defaultUserShell = pkgs.fish;
  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Moscow";
  location.latitude = 55.75;
  location.longitude = 37.61;

  environment = {
    variables = {
      EDITOR = "nvim";
    };
  };

  systemd.tmpfiles.rules =
    [
      "d /home/${vars.user}/.mail           0700 1000 1000"
      "d /home/${vars.user}/.backup         0700 1000 1000"
      "d /home/${vars.user}/.password-store 0700 1000 1000"
      "d /home/${vars.user}/.secrets        0700 1000 1000"
      "d /home/${vars.user}/Wallpapers      0700 1000 1000"
    ];

  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      programs.git = {
        enable = true;
        extraConfig = {
          "push" = { default = "current"; };
          "rerere" = { enabled = 1; };
          "core" = {
            excludesfile = "~/.gitignore";
            pager = ''
              delta --plus-color="#16271C" --minus-color="#331F21" --theme='ansi-dark'
            '';
          };
          "interactive" = {
            diffFilter = "delta --color-only";
          };
        };

        aliases = {
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(magenta)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
          recent-branches = "branch --sort=-committerdate";
        };
      };

      home.file.".icons/default/index.theme".text = ''
        [Icon Theme]
        Name=Default
        Comment=Default Cursor Theme
        Inherits=Vanilla-DMZ
      '';
      home.file.".config/qt5ct/qt5ct.conf".text = ''
        [Appearance]
        icon_theme=Papirus-Dark
        style=gtk2

        [Fonts]
        fixed="@Variant(\0\0\0@\0\0\0\x10\0T\0\x65\0r\0m\0i\0n\0u\0s@,\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)"
        general="@Variant(\0\0\0@\0\0\0\x10\0T\0\x65\0r\0m\0i\0n\0u\0s@,\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)"
      '';

      home.file.".config/zathura/zathurarc".source = ../home/.config/zathura/zathurarc;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source = ../home/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source = ../home/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source = ../home/.config/roxterm.sourceforge.net/Global;

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../home/.config/alacritty/alacritty-scratchpad.yml;

      home.file.".config/mpv/mpv.conf".source = ../home/.config/mpv/mpv.conf;

      home.file.".eslintrc.json".source = ../home/.eslintrc.json;
      home.file.".npmrc".source = ../home/.npmrc;

      home.file.".config/astroid/config".source = ../home/.config/astroid/config;
      home.file.".config/astroid/poll.sh".source = ../home/.config/astroid/poll.sh;
      home.file.".config/astroid/hooks/toggle".source = ../home/.config/astroid/hooks/toggle;
      home.file.".config/astroid/keybindings".source = ../home/.config/astroid/keybindings;

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

      home.file.".config/nvim/init.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/ginit.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../home/.config/nvim/coc-settings.json;

      home.file.".config/fish/config.fish".source = ../home/.config/fish/config.fish;
      home.file.".config/fish/conf.d/z.fish".source = ../home/.config/fish/conf.d/z.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../home/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../home/.config/fish/functions/fish_print_git_action.fish;
    };
  };
}
