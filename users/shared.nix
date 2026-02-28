{
  lib,
  pkgs,
  user,
  email,
  name,
  ...
}: {
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

  time.timeZone = lib.mkDefault "Europe/Moscow";
  location.latitude = lib.mkDefault 55.75;
  location.longitude = lib.mkDefault 37.61;

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
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      home.stateVersion = "24.05";

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

      home.file.".config/mpv/mpv.conf".source = lib.mkDefault ../users/shared/mpv/mpv.conf;
      home.file.".config/mpv/input.conf".source = ../users/shared/mpv/input.conf;
      home.file.".config/mpv/scripts/autoload.lua".source = ../users/shared/mpv/scripts/autoload.lua;
      home.file.".config/mpv/scripts/delete_file.lua".source = ../users/shared/mpv/scripts/delete_file.lua;

      home.file.".npmrc".source = ../users/shared/.npmrc;

      home.file.".config/nvim/init.lua".source = ../users/shared/nvim/init.lua;

      home.file.".config/fish/config.fish".source = ../users/shared/fish/config.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/fish/functions/fish_print_git_action.fish;

      home.file.".iex.exs".source = ../users/shared/.iex.exs;

      home.file.".local/share/nemo/actions/aunpack.nemo_action".text = ''
      [Nemo Action]
      Name=Extract here
      Comment=Extract the selected archive(s) using aunpack
      Exec=aunpack -X %P %F
      Icon=package-x-generic
      Selection=Any
      Extensions=zip;tar;gz;bz2;7z;rar;
      Quote=double
      '';
    };
  };
}
