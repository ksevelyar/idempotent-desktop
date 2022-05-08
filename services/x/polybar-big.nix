{ user, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
    [
      polybar
    ];

  home-manager = {
    users.${user} = {
      home.file.".config/polybar/config".source = ../../users/shared/polybar/config-big;
      home.file.".config/polybar/weather.sh".source = ../../users/shared/polybar/weather.sh;
      home.file.".config/polybar/vpn.fish".source = ../../users/shared/polybar/vpn.fish;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../../users/shared/polybar/local_and_public_ips.sh;
    };
  };
}
