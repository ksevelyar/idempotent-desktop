{ config, pkgs, ... }:
{
  imports =
    [
      ./shared.nix
      ./shared-gui.nix
    ];

  vars.user = "kh";
  home-manager = {
    users.kh = {
      programs.git = {
        userName = "Tatiana Kh";
        userEmail = "ts.khol@gmail.com";
      };

      # xsession.windowManager.xmonad.config = ../home/.xmonad/xmonad.hs;
    };
  };
}
