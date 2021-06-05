{ lib, pkgs, user, email, name, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = name;

    # Enable ‘sudo’ for the user.
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "nginx"
      "dialout"
      "docker"
      "jackaudio"
    ];
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/${user} && chown ${user}:users /nix/var/nix/profiles/per-user/${user}";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-${user}.service" ];
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
      # tomb mount points
      "d /home/${user}/.mail           0700 1000 1000"
      "d /home/${user}/.backup         0700 1000 1000"
      "d /home/${user}/.password-store 0700 1000 1000"
      "d /home/${user}/.ssh            0700 1000 1000"

      "d /home/${user}/.secrets        0700 1000 1000"
      "d /home/${user}/Wallpapers      0700 1000 1000"
      "d /home/${user}/Screenshots     0700 1000 1000"
      "d /home/${user}/Documents       0700 1000 1000"
      "d /home/${user}/Pictures        0700 1000 1000"
      "d /home/${user}/Photos          0700 1000 1000"
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

      home.file.".config/zathura/zathurarc".source = ../users/shared/.config/zathura/zathurarc;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source = ../users/shared/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source = ../users/shared/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source = ../users/shared/.config/roxterm.sourceforge.net/Global;

      home.file.".config/alacritty/alacritty.yml".source = lib.mkDefault ../users/shared/.config/alacritty/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = lib.mkDefault ../users/shared/.config/alacritty/alacritty-scratchpad.yml;

      home.file.".config/mpv/mpv.conf".source = ../users/shared/.config/mpv/mpv.conf;
      home.file.".config/mpv/input.conf".source = ../users/shared/.config/mpv/input.conf;

      home.file.".npmrc".source = ../users/shared/.npmrc;

      home.file.".config/astroid/config".source = ../users/shared/.config/astroid/config;
      home.file.".config/astroid/poll.sh".source = ../users/shared/.config/astroid/poll.sh;
      home.file.".config/astroid/hooks/toggle".source = ../users/shared/.config/astroid/hooks/toggle;
      home.file.".config/astroid/keybindings".source = ../users/shared/.config/astroid/keybindings;

      home.file.".config/nvim/init.vim".source = ../users/shared/.config/nvim/init.vim;
      home.file.".config/nvim/ginit.vim".source = ../users/shared/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../users/shared/.config/nvim/coc-settings.json;

      home.file.".config/fish/config.fish".source = ../users/shared/.config/fish/config.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/.config/fish/functions/fish_print_git_action.fish;
    };
  };
}
