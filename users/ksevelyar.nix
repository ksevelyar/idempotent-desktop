{ config, pkgs, lib, ... }:
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
        (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &
        sh ~/.fehbg
        xsetroot -cursor_name left_ptr
        
        lxqt-policykit-agent &
        xxkb &
        xcape -e 'Super_R=Super_R|X' # run rofi with single win key
        sh ~/.config/conky/launch.sh
      '';
    };
  };
}
