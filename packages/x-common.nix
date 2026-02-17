{pkgs, ...}: {
  environment = {
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };

    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Dracula
        gtk-icon-theme-name=Papirus-Dark-Maia
        gtk-font-name=Terminus 16
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

    # override with the ~/mimeapps.list that can be edited with xfce4-mime-settings
    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        inode/directory=nemo.desktop

        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        text/html=firefox.desktop

        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;

        image/gif=imv.desktop;
        image/jpeg=imv.desktop;
        image/png=imv.desktop;
      '';
    };

    etc."imv_config".source = ../users/shared/imv/config;
  };

  programs.browserpass.enable = true;
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [
    nemo

    # net
    firefox
    ungoogled-chromium
    # yt-dlp -f 'bv[height<=1080]+ba' 'https://www.youtube.com/playlist?list=PLRnZ3k_L91GmDn2eWpvJ6-SLXpNlLAihu'
    yt-dlp
    transmission_4-gtk

    # vnc
    x11vnc # vnc-server
    tigervnc # vncviewer

    # readers
    evince

    anki

    # themes
    lxappearance
    vanilla-dmz
    dracula-theme
    adwaita-qt
    papirus-maia-icon-theme

    # sec
    pinentry-gtk2

    # im
    telegram-desktop
    mumble

    # sys
    alacritty
    st # alacritty fallback
    gparted
    xxkb
    xorg.xev
    xorg.xfd
    xorg.xkbcomp
    xdotool
    seturgent

    # screenshot region or fullscreen
    # watch -n2 'maim ~/screenshots/doom2/$(date +%Y-%m-%d-%H-%M-%S).png'
    maim
    vokoscreen-ng # record desktop

    xclip
    rofi
    rofimoji
    libnotify
    brightnessctl
    arandr # gui for external monitors

    # media
    libva-utils
    mpv

    # fd . ~/wallpapers/ | shuf | imv
    # ls -t ~/wallpapers/* | imv
    imv
    nomacs
    qview
    ueberzugpp

    # xray
    throne
  ];
}
