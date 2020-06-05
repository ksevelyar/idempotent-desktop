{ config, pkgs, ... }:
{
  services.tor = {
    enable = true;
    client.enable = true; # 127.0.0.1:9063
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      tor-browser-bundle-bin
      # onionshare-gui
    ];
}
