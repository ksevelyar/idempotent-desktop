{ config, pkgs, lib, ... }:
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
        application/x-extension-htm=firefox.desktop
        application/x-extension-html=firefox.desktop
        application/x-extension-shtml=firefox.desktop
        application/xhtml+xml=firefox.desktop
        application/x-extension-xhtml=firefox.desktop
        application/x-extension-xht=firefox.desktop
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop
        x-scheme-handler/about=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;
        image/png=nomacs.desktop;
        image/jpeg=nomacs.desktop;
        application/pdf=org.gnome.Evince.desktop;

        [Added Associations]
        x-scheme-handler/http=firefox.desktop;
        x-scheme-handler/https=firefox.desktop;
        x-scheme-handler/ftp=firefox.desktop;
        x-scheme-handler/chrome=firefox.desktop;
        text/html=firefox.desktop;
        application/x-extension-htm=firefox.desktop;
        application/x-extension-html=firefox.desktop;
        application/x-extension-shtml=firefox.desktop;
        application/xhtml+xml=firefox.desktop;
        application/x-extension-xhtml=firefox.desktop;
        application/x-extension-xht=firefox.desktop;
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop;
        application/pdf=org.gnome.Evince.desktop;
        image/jpeg=nomacs.desktop;
        image/png=nomacs.desktop;
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;      
      '';
    };

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };

  users.defaultUserShell = pkgs.fish;
  users.users.root = {
    # jkl
    initialHashedPassword = lib.mkForce "$6$krVCM45j$6lYj1WKEX8q7hMZGG6ctAG6kQDDND/ngpGOwENT1TIOD25F0yep/VvIuL.v9XyRntLJ61Pr8r7djynGy5lh3x0";
  };
  # Enable SSH in the boot process and allow root to login.
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
  services.openssh = {
    enable = true;
    permitRootLogin = lib.mkForce "yes";
    passwordAuthentication = lib.mkForce true;
  };
  users.users.mrpoppybutthole = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/mrpoppybutthole";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-mrpoppybutthole.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  services.mingetty.autologinUser = lib.mkForce "mrpoppybutthole";
  services.mingetty.greetingLine = lib.mkForce ''\l'';

  environment.shellAliases = {
    wire-dotfiles = "sh /etc/scripts/wire-dotfiles.sh";
  };
  # NOTE: /mnt and /mnt/boot should be mounted before this command
  environment.etc."/scripts/wire-dotfiles.sh".text = ''
    # create blank hardware-configuration.nix & configuration.nix
    sudo nixos-generate-config --root /tmp

    # downloand repo 
    sudo git clone https://github.com/ksevelyar/dotfiles.git /mnt/etc/nixos

    # make config work on live-usb
    sudo ln -s /mnt/etc/nixos /etc/nixos
  '';

  home-manager = {
    useGlobalPkgs = true;

    users.mrpoppybutthole = {
      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = /etc/nixos/home/.xmonad/xmonad.hs;

      home.file."Wallpapers/1.png".source = /etc/nixos/home/wallpapers/1.png;

      home.file.".config/dunst/dunstrc".source = /etc/nixos/home/.config/dunst/dunstrc;

      home.file.".config/polybar/launch.sh".source = /etc/nixos/home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = /etc/nixos/home/.config/polybar/config;
      home.file.".config/polybar/gpmdp-next.sh".source =
        /etc/nixos/home/.config/polybar/gpmdp-next.sh;
      home.file.".config/polybar/gpmdp-rewind.sh".source =
        /etc/nixos/home/.config/polybar/gpmdp-rewind.sh;
      home.file.".config/polybar/gpmdp.sh".source = /etc/nixos/home/.config/polybar/gpmdp.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source =
        /etc/nixos/home/.config/polybar/local_and_public_ips.sh;

      home.file.".config/rofi/joker.rasi".source = /etc/nixos/home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = /etc/nixos/home/.config/rofi/config.rasi;

      home.file.".config/roxterm.sourceforge.net/Colours/joker".source =
        /etc/nixos/home/.config/roxterm.sourceforge.net/Colours/joker;
      home.file.".config/roxterm.sourceforge.net/Profiles/Default".source =
        /etc/nixos/home/.config/roxterm.sourceforge.net/Profiles/Default;
      home.file.".config/roxterm.sourceforge.net/Global".source =
        /etc/nixos/home/.config/roxterm.sourceforge.net/Global;


      home.file.".config/nvim/init.vim".source = /etc/nixos/home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = /etc/nixos/home/.config/nvim/coc-settings.json;

      home.file.".config/alacritty/alacritty.yml".source = /etc/nixos/home/.config/alacritty/alacritty.yml;
      home.file.".config/fish/config.fish".text = ''
        set fish_greeting
        git_aliases

        if not functions -q fisher
          set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
          curl -s https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish 

          fish -c fisher > /dev/null 2>&1
        end

        if [ ! -e ~/.config/nvim/autoload/plug.vim ]
          echo 'Installing plug-vim...'
          curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
          nvim +PlugInstall +qall > /dev/null
          echo -e "Done.\n"
        end

        if status --is-login
          sh /etc/scripts/system-info.sh 
        end
      '';
      home.file.".config/fish/fishfile".source = /etc/nixos/home/.config/fish/fishfile;
      home.file.".config/fish/functions/git_aliases.fish".source =
        /etc/nixos/home/.config/fish/functions/git_aliases.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source =
        /etc/nixos/home/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source =
        /etc/nixos/home/.config/fish/functions/fish_print_git_action.fish;

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
