{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      xonotic-dedicated
    ];

  networking.firewall.allowedUDPPorts = [ 26000 ];
}
