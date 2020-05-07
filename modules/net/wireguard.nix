{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      wireguard
    ];

  networking.firewall.allowedUDPPorts = [ 51820 ];
}
