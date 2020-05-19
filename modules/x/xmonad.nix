{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        polybar
        xlsfonts
        xcape

        lxqt.lxqt-policykit
        libnotify
        dunst
        xfce.xfce4-settings # xfce4-mime-settings
      ];

  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    displayManager = {
      defaultSession = "none+xmonad";
      sessionCommands = lib.mkDefault ''
        (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &
        sh ~/.fehbg
        xsetroot -cursor_name left_ptr
        
        lxqt-policykit-agent &
        xxkb &
        xcape -e 'Super_R=Super_R|X'
      '';
    };

    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      xmonad.extraPackages = hpkgs: [
        hpkgs.xmonad-contrib
        hpkgs.xmonad-extras
        hpkgs.xmonad
      ];
    };
  };
}
