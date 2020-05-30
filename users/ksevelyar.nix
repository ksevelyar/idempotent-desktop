{ config, pkgs, lib, ... }:
let
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../assets/layout.xkb} $out
  '';
in

{
  vars.user = "ksevelyar";

  # dev hosts
  networking.extraHosts =
    ''
      127.0.0.1 l.lcl
      127.0.0.1 or.lcl
    '';

  home-manager = {
    users.ksevelyar = {
      # home.file."Wallpapers/1.png".source = ../home/wallpapers/1.png;
      programs.git = {
        userName = "Sergey Zubkov";
        userEmail = "ksevelyar@gmail.com";
      };
    };
  };

  services.xserver = {
    displayManager = {
      sessionCommands = ''
        ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY
        (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &
        sh ~/.fehbg
        xsetroot -cursor_name left_ptr
        
        lxqt-policykit-agent &
        xxkb &
        xcape -e 'Super_R=Super_R|X'
        sh ~/.config/conky/launch.sh
      '';
    };
  };
}
