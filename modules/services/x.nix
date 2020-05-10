{ pkgs, lib, ... }:
{
  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  services.tor = {
    enable = true;
    client.enable = true;
  };

  services.ratbagd.enable = true;

  services.udisks2.enable = true;
  # services.devmon.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;
    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.fail2ban = {
    enable = true;
  };
  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = true;
  };
  # Allow sshd to be started manually through sudo systemctl start sshd
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [];

  services.journald.extraConfig = "SystemMaxUse=700M";

  services.picom = {
    enable = true;
    fade = false;
    shadow = false;
    backend = "glx";
    vSync = true;
  };

  console.useXkbConfig = true;
  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      accelProfile = "flat"; # flat profile for touchpads
      naturalScrolling = false;
      disableWhileTyping = true;
      clickMethod = "buttonareas";
      scrollMethod = lib.mkDefault "edge";
    };

    config = ''
      Section "InputClass"
        Identifier "Mouse"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "adaptive"
      EndSection
    '';

    serverFlagsSection = ''
      Option "BlankTime" "120"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    desktopManager.plasma5.enable = false;
    displayManager.sddm = {
      enable = true;
    };
    displayManager.lightdm = {
      enable = false;
      background = "/etc/nixos/assets/displayManager.png";

      greeters.enso = {
        enable = false;
        blur = true;

        theme = {
          name = "Ant-Dracula";
          package = pkgs.ant-dracula-theme;
        };
        iconTheme = {
          name = "ePapirus";
          package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
        };
      };

      greeters.gtk = {
        enable = false;
        indicators = [
          "~host"
          "~spacer"
          "~clock"
          "~spacer"
          "~session"
        ];

        theme = {
          name = "Ant-Dracula";
          package = pkgs.ant-dracula-theme;
        };
        iconTheme = {
          name = "ePapirus";
          package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
        };
      };
    };

    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager = {
      xterm.enable = false;
      gnome3.enable = false;
      pantheon.enable = false;
      lxqt.enable = false;
    };
  };

  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant-Dracula
        gtk-icon-theme-name=ePapirus
        gtk-font-name=Anka/Coder 13
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
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };
}
