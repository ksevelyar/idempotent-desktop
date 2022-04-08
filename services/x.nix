{ pkgs, lib, ... }:
{
  services.udisks2.enable = true;
  services.greenclip.enable = true;
  services.gvfs.enable = lib.mkForce false;

  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      touchpad = {
        accelProfile = lib.mkDefault "adaptive";
        disableWhileTyping = true;
        clickMethod = "buttonareas";
        scrollMethod = lib.mkDefault "edge";
        naturalScrolling = false;
      };
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
      background = "/etc/nixos/assets/wallpapers/akira.png";

      greeters.enso = {
        enable = true;
        blur = false;

        theme = {
          name = "Dracula";
          package = pkgs.dracula-theme;
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
