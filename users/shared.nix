{
  lib,
  pkgs,
  user,
  email,
  name,
  config,
  ...

}:
let
  joker-vim = pkgs.vimUtils.buildVimPlugin {
    name = "joker-vim";
    src = pkgs.fetchFromGitHub {
      owner = "ksevelyar";
      repo = "joker.vim";
      rev = "main";
      sha256 = "sha256-f5g9sa+2c9IFmicCHaIvIuoTUe7OUN1/1HshQbcfuyc=";
    };
  };

in {
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
  i18n.defaultLocale = "en_GB.UTF-8";

  time.timeZone = lib.mkDefault "Europe/Moscow";
  location.latitude = lib.mkDefault 55.75;
  location.longitude = lib.mkDefault 37.61;

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

      xdg.mimeApps = {
        enable = true;

        defaultApplications = lib.mkDefault {
          "inode/directory" = "nemo.desktop";

          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "text/html" = "firefox.desktop";

          "video/*" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "video/mpeg" = "mpv.desktop";

          "image/*" = "com.interversehq.qView.desktop";
          "image/png" = "com.interversehq.qView.desktop";
          "image/jpg" = "com.interversehq.qView.desktop";

          "text/plain" = "nvim.desktop";
          "text/markdown" = "nvim.desktop";
          "text/x-markdown" = "nvim.desktop";
        };
      };

      xdg.desktopEntries = {
        "nvim" = {
          name = "Neovim";
          exec = "alacritty -e nvim %F";
          terminal = false;
          mimeType = [
            "text/plain"
            "text/markdown"
            "text/x-markdown"
            "text/html"
          ];
          icon = "nvim";
          categories = ["Utility" "TextEditor"];
        };
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;

        plugins = with pkgs.vimPlugins; [
          # UI & Status Line
          lualine-nvim
          nvim-web-devicons

          # File Explorer
          nvim-tree-lua

          # Search & Navigation
          telescope-nvim
          plenary-nvim
          leap-nvim

          # Git Integration
          vim-fugitive
          gitsigns-nvim

          # LSP & Completion
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          cmp-vsnip
          vim-vsnip

          # Syntax & Highlighting
          nvim-treesitter.withAllGrammars
          nvim-colorizer-lua

          # Utilities
          indent-blankline-nvim
          direnv-vim
          vim-openscad

          # Themes
          joker-vim
          oxocarbon-nvim
        ];
      };

      services.wlsunset = {
        enable = config.programs.hyprland.enable;

        sunrise = lib.mkDefault "06:00";
        sunset = lib.mkDefault "18:00";
        temperature.day = lib.mkDefault 6500;
        temperature.night = lib.mkDefault 4000;
      };

      services.mako = {
        enable = config.programs.hyprland.enable;
        settings = {
          font = "CaskaydiaMono Nerd Font 15";
          default-timeout = 4000;
          background-color = "#16161E";
          text-color = "#d0d0d0";
          border-color = "#3a3a45";
          border-size = 2;
          padding = "12";
          outer-margin = "8";
          border-radius = 8;
          anchor = "top-right";
          text-alignment = "center";
          max-visible = 5;
          max-history = 20;
        };
      };

      home.pointerCursor = lib.mkDefault {
        x11.enable = true;
        gtk.enable = true;
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        size = lib.mkDefault 24;
      };

      gtk = {
        enable = true;

        theme = {
          name = "Dracula";
          package = pkgs.dracula-theme;
        };

        font = {
          name = "CaskaydiaMono Nerd Font";
          size = 15;
        };

        iconTheme = {
          name = "Dracula";
          package = pkgs.dracula-icon-theme;
        };
      };
      qt = {
        enable = true;
        platformTheme.name = "gtk3";
      };

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

      home.file.".config/rofi/grey.rasi".source = ../users/shared/rofi/grey.rasi;
      home.file.".config/rofi/config.rasi".source = lib.mkDefault ../users/shared/rofi/config.rasi;
      home.file.".config/rofimoji.rc".source = lib.mkDefault ../users/shared/rofi/rofimoji.rc;

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

      home.file.".config/zellij/config.kdl".text = ''
        theme "gruvbox-dark"
        show_startup_tips false
        show_release_notes false
      '';
    };
  };
}
