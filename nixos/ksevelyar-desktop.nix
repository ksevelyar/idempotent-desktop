{ config, pkgs, ... }:
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  networking.hostName = "laundry";
  powerManagement.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  location.latitude = 55.75;
  location.longitude = 37.61;

  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Pop-dark
        gtk-icon-theme-name=Paper-Mono-Dark
        gtk-font-name=Anka/Coder 13
        # gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name=Paper
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
        x-scheme-handler/unknown=firefox.desktop
      '';
    };

    etc."xdg/nvim/sysinit.vim".text = builtins.readFile ./init.vim;

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ksevelyar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    useGlobalPkgs = true;
    users.ksevelyar = {
      programs.git = {
        enable = true;
        userName = "Sergey Zubkov";
        userEmail = "ksevelyar@gmail.com";
      };

      home.file.".icons/default".text = ''
        [Icon Theme]
        Name=Default
        Comment=Default Cursor Theme
        Inherits=Vanilla-DMZ
      '';

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --randomize --bg-fill --no-fehbg ~/Wallpapers/
      '';

    };

  };


}
