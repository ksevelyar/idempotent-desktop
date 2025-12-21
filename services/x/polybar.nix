{
  user,
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = let
    polybar = pkgs.polybar.override {
      pulseSupport = true;
    };

    polybar-weather = pkgs.rustPlatform.buildRustPackage {
      pname = "polybar-weather";
      version = "0.1.0";
      src = pkgs.lib.cleanSource ../../services/x/polybar-weather;
      cargoLock = {
        lockFile = ../../services/x/polybar-weather/Cargo.lock;
      };
      doCheck = false;

      env = {
        LATITUDE = toString config.location.latitude;
        LONGITUDE = toString config.location.longitude;
      };
    };
  in [
    polybar
    polybar-weather
  ];

  home-manager = {
    users.${user} = {
      home.file.".config/polybar/config.ini".source = lib.mkDefault ../../users/shared/polybar/config.ini;
      home.file.".config/polybar/vpn.fish".source = ../../users/shared/polybar/vpn.fish;
      home.file.".config/polybar/local_and_public_ips.sh".source = ../../users/shared/polybar/local_and_public_ips.sh;
    };
  };
}
