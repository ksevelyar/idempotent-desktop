{ config, pkgs, ... }:
{
  services.tor = {
    enable = true;
    client.enable = true;
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      tor-browser-bundle-bin
    ];
}
