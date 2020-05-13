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
      home.file.".Xresources".source = ../home/.Xresources;

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
      home.file.".config/polybar/weather.sh".source = ../home/.config/polybar/weather.sh;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../home/.config/polybar/local_and_public_ips.sh;

      home.file.".config/rofi/joker.rasi".source = ../home/.config/rofi/joker.rasi;
      home.file.".config/rofi/config.rasi".source = ../home/.config/rofi/config.rasi;

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
      home.file.".config/alacritty/alacritty-scratchpad.yml".source = ../home/.config/alacritty/alacritty-scratchpad.yml;

      home.file.".config/mpv/mpv.conf".source = ../home/.config/mpv/mpv.conf;

      home.file.".icons/default/index.theme".text = ''
        [Icon Theme]
        Name=Default
        Comment=Default Cursor Theme
        Inherits=Vanilla-DMZ
      '';
      home.file.".local/share/fonts/ter-u14n.otb".source = ../assets/fonts/ter-u14n.otb;
      home.file.".local/share/fonts/ter-u14b.otb".source = ../assets/fonts/ter-u14b.otb;
      home.file.".local/share/fonts/ter-u16n.otb".source = ../assets/fonts/ter-u16n.otb;
      home.file.".local/share/fonts/ter-u16b.otb".source = ../assets/fonts/ter-u16b.otb;
      home.file.".local/share/fonts/ter-u18n.otb".source = ../assets/fonts/ter-u18n.otb;
      home.file.".local/share/fonts/ter-u18b.otb".source = ../assets/fonts/ter-u18b.otb;

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/Wallpapers/
      '';

      home.file.".ssh/config".source = ../home/.ssh/config;
    };
  };
}
