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

    # Browsers & networking
    firefox
    ungoogled-chromium
    yt-dlp
    transmission_4-gtk

    # Document/media viewers
    evince
    mpv
    imv
    qview

    # Productivity
    anki
    telegram-desktop
    rustdesk-flutter
    mumble

    # Terminal emulators
    alacritty
    foot

    # System utilities
    gparted
    brightnessctl
    libnotify

    rofi
    rofimoji

    # Theme/icon packages
    lxappearance

    # Security
    pinentry-gtk2

    # Media/VA-API
    libva-utils
  ];
}
