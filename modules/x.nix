{ config, pkgs, lib, ... }:
{
  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
  };

  services.xserver = {
    enable = true;
    displayManager = {
      # defaultSession = "none+xmonad";
      sessionCommands = ''
        sh ~/.fehbg &
        xsetroot -cursor_name left_ptr

        xset s off
        xset -dpms
      '';
    };

    displayManager.lightdm = {
      enable = true;
      background = "/etc/nixos/assets/displayManager.png";

      greeters.gtk = {
        enable = true;
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

    # windowManager = {
    #   xmonad.enable = true;
    #   xmonad.enableContribAndExtras = true;
    #   xmonad.extraPackages = hpkgs: [
    #     hpkgs.xmonad-contrib
    #     hpkgs.xmonad-extras
    #     hpkgs.xmonad
    #   ];
    # };
  };
}
