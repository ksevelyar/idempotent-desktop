{pkgs, ...}: {
  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  programs.browserpass.enable = true;

  environment.systemPackages = with pkgs; [
    dracula-theme
    dracula-icon-theme

    cliphist
    wl-clipboard
    wev
    nemo
    wdisplays

    firefox
    ungoogled-chromium
    yt-dlp
    transmission_4-gtk

    evince
    mpv
    swayimg
    qview

    anki
    telegram-desktop
    rustdesk-flutter
    mumble

    alacritty
    foot

    gparted
    brightnessctl
    libnotify

    rofi
    rofimoji

    lxappearance
    pinentry-gtk2
    libva-utils
  ];
}
