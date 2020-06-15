{ pkgs, lib, ... }:
{
  services.ratbagd.enable = true;
  services.udisks2.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;
    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.picom = {
    enable = lib.mkDefault true;
    fade = lib.mkDefault true;
    fadeDelta = lib.mkDefault 5;
    shadow = lib.mkDefault false;
    backend = lib.mkDefault "glx";
    vSync = true;
  };

  services.xserver = {
    enable = true;

    # TODO: move to laptop.nix
    libinput = {
      enable = true;
      accelProfile = "flat"; # flat profile for touchpads
      naturalScrolling = false;
      disableWhileTyping = true;
      clickMethod = "buttonareas";
      scrollMethod = lib.mkDefault "edge";
      # additionalOptions = ''MatchIsTouchpad "on"'';
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

    displayManager.lightdm = {
      enable = true;
      background = "/etc/nixos/assets/displayManager.png";

      greeters.enso = {
        enable = true;
        blur = false;

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
    };
  };
}
