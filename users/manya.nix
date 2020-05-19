{ config, pkgs, ... }:
{
  vars.user = "manya";

  imports =
    [
      ./shared.nix
      ./x-shared.nix
    ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  home-manager = {
    users.manya = {
      programs.git = {
        userName = "Maria Elizarova";
        userEmail = "porosenie@gmail.com";
      };
      xsession.windowManager.xmonad.config = ../home/.xmonad/xmonad.hs;
      home.file."Wallpapers/1.png".source = ../home/wallpapers/1.png;
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
        xcape -e 'Super_R=Super_R|X'
      '';
    };
  };

}
