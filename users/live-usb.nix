{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./shared.nix
    ];

  users.users.root = {
    # jkl
    initialHashedPassword = lib.mkForce "$6$krVCM45j$6lYj1WKEX8q7hMZGG6ctAG6kQDDND/ngpGOwENT1TIOD25F0yep/VvIuL.v9XyRntLJ61Pr8r7djynGy5lh3x0";
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
    refresh-channels
    # create blank hardware-configuration.nix & configuration.nix
    sudo nixos-generate-config --root /mnt
    bat /mnt/etc/nixos/*.nix
    sudo cp -ra /mnt/etc/nixos{,.bak}

    # downloand repo 
    sudo git clone https://github.com/ksevelyar/dotfiles.git /mnt/etc/nixos
    bat /mnt/etc/nixos/*.nix
    nvim /mnt/etc/nixos/configuration.nix
  '';

  home-manager = {
    users.mrpoppybutthole = {
      xsession.windowManager.xmonad.config = ../home/.xmonad/xmonad.hs;

      home.file."Wallpapers/1.png".source = ../home/wallpapers/1.png;

      home.file.".xxkbrc".source = ../home/.xxkbrc;
      home.file.".eslintrc.json".source = ../home/.eslintrc.json;
      home.file.".npmrc".source = ../home/.npmrc;

      home.file.".config/dunst/dunstrc".source = ../home/.config/dunst/dunstrc;

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


      home.file.".config/nvim/init.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../home/.config/nvim/coc-settings.json;

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
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
      home.file.".config/fish/fishfile".source = ../home/.config/fish/fishfile;
      home.file.".config/fish/functions/git_aliases.fish".source =
        ../home/.config/fish/functions/git_aliases.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source =
        ../home/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source =
        ../home/.config/fish/functions/fish_print_git_action.fish;

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
      '';
    };
  };
}
