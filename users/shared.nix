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
      home.file.".config/nixpkgs/config.nix".text = ''
        { allowUnfree = true; }
      '';

      home.file.".config/git/config".source = ../users/shared/.config/git/config;
      home.file.".config/git/ignore".source = ../users/shared/.config/git/ignore;
      home.file.".config/git/user".text = ''
        [user]
        email = ${email}
        name = ${name}
      '';

      home.file.".config/broot/conf.hjson".source = ../users/shared/.config/broot/conf.hjson;
      home.file.".config/zathura/zathurarc".source = ../users/shared/.config/zathura/zathurarc;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source = ../users/shared/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source = ../users/shared/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source = ../users/shared/.config/roxterm.sourceforge.net/Global;

      home.file.".config/alacritty/alacritty.yml".source = lib.mkDefault ../users/shared/.config/alacritty/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = lib.mkDefault ../users/shared/.config/alacritty/alacritty-scratchpad.yml;

      home.file.".config/ncmpcpp/config".source = ../users/shared/.config/ncmpcpp/config;
      home.file.".config/mpv/mpv.conf".source = ../users/shared/.config/mpv/mpv.conf;
      home.file.".config/mpv/input.conf".source = ../users/shared/.config/mpv/input.conf;

      home.file.".npmrc".source = ../users/shared/.npmrc;

      home.file.".config/nvim/init.vim".source = ../users/shared/.config/nvim/init.vim;
      home.file.".config/nvim/ginit.vim".source = ../users/shared/.config/nvim/init.vim;
      home.file.".config/nvim/lua/config.lua".source = ../users/shared/.config/nvim/lua/config.lua;

      home.file.".config/fish/config.fish".source = ../users/shared/.config/fish/config.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/.config/fish/functions/fish_print_git_action.fish;

      home.file.".iex.exs".source = ../users/shared/.iex.exs;
    };
  };
}
