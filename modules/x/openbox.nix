{ config, pkgs, lib, ... }:
let
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../../assets/layout.xkb} $out
  '';
in
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

        libnotify
        dunst

        openbox-menu
        obconf
      ];

  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  console.useXkbConfig = true;

  # services.xserver.desktopManager.lxqt.enable = true;
  services.xserver = {
    displayManager = {
      sessionCommands = ''
        # ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY
        sh ~/.fehbg
        xsetroot -cursor_name left_ptr
        (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &

        lxqt-policykit-agent &
        xxkb &
        xcape -e 'Super_R=Super_R|X'
      '';
    };

    windowManager = {
      openbox.enable = true;
    };
  };
}
