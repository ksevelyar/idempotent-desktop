args@{ config, pkgs, lib, ... }:
let
  user = "manya";
  email = "porosenie@gmail.com";
  name = "Maria Elizarova";
in
{
  imports = [
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
    (import ../services/x/xmonad.nix (args // { user = user; }))
    (import ../packages/firefox.nix (args // { user = user; }))
  ];

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_big.png;
  boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

  home-manager = {
    users.manya = {
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
