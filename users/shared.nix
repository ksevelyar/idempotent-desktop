{ lib, pkgs, user, email, name, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = name;

    extraGroups = [
      # Enable sudo
      "wheel"
      "networkmanager"
      "libvirtd"
      "nginx"
      "dialout"
      "docker"
      "jackaudio"
      "scanner"
      "lp"
    ];
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

  systemd.tmpfiles.rules = [
    "d /home/${user}/code        0700 ${user} 1000"
    "d /home/${user}/.secrets    0700 ${user} 1000"
    "d /home/${user}/wallpapers  0700 ${user} 1000"
    "d /home/${user}/screenshots 0700 ${user} 1000"
    "d /home/${user}/documents   0700 ${user} 1000"
    "d /home/${user}/downloads   0700 ${user} 1000"
    "d /home/${user}/notes       0700 ${user} 1000"
    "d /home/${user}/pics        0700 ${user} 1000"
    "d /home/${user}/photos      0700 ${user} 1000"
    "d /home/${user}/sshfs       0700 ${user} 1000"
    "d /home/${user}/learn       0700 ${user} 1000"
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      home.stateVersion = "23.11";

      home.pointerCursor = lib.mkDefault {
        x11.enable = true;
        gtk.enable = true;
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        size = 16;
      };

      home.file.".gtkrc-2.0".text = ''
        gtk-theme-name="Dracula"
        gtk-icon-theme-name="Papirus-Dark-Maia"
        gtk-font-name="Terminus 16"
      '';

      home.file.".config/nixpkgs/config.nix".text = ''
        { allowUnfree = true; }
      '';

      home.file.".config/git/config".source = ../users/shared/git/config;
      home.file.".config/git/ignore".source = ../users/shared/git/ignore;
      home.file.".config/git/user".text = ''
        [user]
        email = ${email}
        name = ${name}
      '';

      home.file.".config/broot/conf.hjson".source = ../users/shared/broot/conf.hjson;
      home.file.".config/zathura/zathurarc".source = ../users/shared/zathura/zathurarc;

      home.file.".config/alacritty/alacritty.toml".source = lib.mkDefault ../users/shared/alacritty/alacritty.toml;
      home.file.".config/alacritty/alacritty-scratchpad.toml".source = lib.mkDefault ../users/shared/alacritty/alacritty-scratchpad.toml;

      home.file.".config/ncmpcpp/config".source = ../users/shared/ncmpcpp/config;
      home.file.".config/mpv/mpv.conf".source = ../users/shared/mpv/mpv.conf;
      home.file.".config/mpv/input.conf".source = ../users/shared/mpv/input.conf;
      home.file.".config/mpv/scripts/autoload.lua".source = ../users/shared/mpv/scripts/autoload.lua;
      home.file.".config/mpv/scripts/delete_file.lua".source = ../users/shared/mpv/scripts/delete_file.lua;

      home.file.".npmrc".source = ../users/shared/.npmrc;

      home.file.".config/nvim/init.vim".source = ../users/shared/nvim/init.vim;
      home.file.".config/nvim/lua/config.lua".source = ../users/shared/nvim/lua/config.lua;

      home.file.".config/fish/config.fish".source = ../users/shared/fish/config.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/fish/functions/fish_print_git_action.fish;

      home.file.".iex.exs".source = ../users/shared/.iex.exs;
    };
  };
}
