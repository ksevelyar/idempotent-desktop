{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        sierra-gtk-theme
        grub2
        os-prober
        hwinfo
        wget
        curl

        # cli
        calcurse
        brightnessctl
        wtf
        python3

        mpv
        smplayer
        vlc
        kodi
        moc

        xbindkeys
        fzf
        gopass
        keepassxc
        firefoxWrapper
        google-chrome
        zathura
        evince
        memtest86-efi

        # Themes
        cura
        conky
        betterlockscreen
        vanilla-dmz
        pop-gtk-theme
        adapta-gtk-theme
        ant-theme
        ant-bloody-theme
        ant-dracula-theme
        nordic
        nordic-polar
        arc-theme
        materia-theme
        paper-icon-theme
        lxappearance-gtk3
        lxqt.lxqt-themes
        adwaita-qt
        skype
        slack
        feh
        transmission_gtk
        aria2
        tdesktop
        polybar

        # Audio
        google-play-music-desktop-player
        audacity
        lmms

        # Dev
        zeal
        neovim
        neovim-qt
        gnvim
        vscode
        ripgrep
        tldr
        nodejs
        elixir
        go
        terminator
        cool-retro-term
        kitty
        asciinema
        alacritty
        universal-ctags
        global
        gcc
        git
        gitg
        gitAndTools.diff-so-fancy
        lazygit
        imagemagick
        gimp

        # Freelance
        libreoffice
        masterpdfeditor

        # Sys
        font-manager
        file
        memtest86plus
        system-config-printer
        jq

        ## fs
        mc
        spaceFM
        xfce.thunar
        exa
        fd
        ranger
        libcaca
        nomacs
        ncdu
        tree
        rsync
        sshfs
        ntfs3g
        exfat
        sshfsFuse
        rclone
        rclone-browser

        lshw
        bat
        inetutils
        maim
        simplescreenrecorder
        smartmontools
        bind
        unzip
        atool
        xclip
        gotop
        htop
        iotop
        powertop
        rofi
        redshift
        bash
        tor-browser-bundle-bin
        pavucontrol
        libnotify
        dunst
        nixpkgs-fmt
        tightvnc
        youtube-dl

        # vncpasswd
        # x0vncserver -rfbauth ~/.vnc/passwd
        tigervnc

        # games
        gzdoom
        steam
        neofetch

        # laptop
        arandr
        acpi
        stable.ulauncher
        openssh

        winusb
      ];
}
