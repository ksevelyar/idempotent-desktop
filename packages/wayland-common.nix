{ pkgs, ... }: {
  environment.variables = {
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  environment.etc."imv_config".source = ../users/shared/imv/config;
  programs.browserpass.enable = true;

  environment.systemPackages = with pkgs; [
    nemo
    wdisplays

    firefox
    ungoogled-chromium
    yt-dlp
    transmission_4-gtk

    evince
    mpv
    imv
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
