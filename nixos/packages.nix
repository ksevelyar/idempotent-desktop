{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sierra-gtk-theme
    grub2
    os-prober
    hwinfo
    wget
    curl

    # cli
    brightnessctl
    wtf

    mpv
    smplayer
    vlc
    kodi
    xbindkeys
    fzf
    gopass
    keepassxc
    firefoxWrapper
    google-chrome
    zathura
    memtest86-efi

    # Themes
    betterlockscreen
    vanilla-dmz
    pop-gtk-theme
    adapta-gtk-theme
    # ant-theme
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
    xorg.xev

    # Audio
    google-play-music-desktop-player
    audacity
    lmms

    # Dev
    python3
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
    file
    memtest86plus
    system-config-printer

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
    xclip
    gotop
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

    steam
    neofetch

    # laptop
    arandr
    acpi
    ulauncher
    openssh

    winusb
  ];
}
