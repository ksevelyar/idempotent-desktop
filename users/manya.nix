{ config, pkgs, lib, ... }:
{
  vars.user = "manya";

  imports =
    [
      ./shared.nix
    ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  home-manager = {
    users.manya = {
      programs.git = {
        userName = "Maria Elizarova";
        userEmail = "porosenie@gmail.com";
      };
      xsession.windowManager.xmonad.config = lib.mkForce ./manya/xmonad.hs;
      home.file.".config/polybar/config".source = lib.mkForce ./manya/polybar/config;
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
