{ config, pkgs, vars, ... }:
{
  vars.user = "kh";
  vars.email = "ts.khol@gmail.com";
  vars.name = "Tatiana Kh";

  networking.extraHosts =
    ''
      127.0.0.1 dev.lcl
    '';

  systemd.tmpfiles.rules =
    [
      "d /vvv 0700 1000 wheel" # secrets
      "d /c 0744 1000 wheel" # code
    ];

  home-manager = {
    users.${vars.user} = {
      # xsession.windowManager.xmonad.config = ../users/shared/.xmonad/xmonad.hs;
      home.file."Wallpapers/Season-01-Gas-station-by-dutchtide.png".source = ../assets/wallpapers/Season-01-Gas-station-by-dutchtide.png;
    };
  };
}
