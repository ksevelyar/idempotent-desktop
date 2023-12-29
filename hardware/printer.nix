{ pkgs, ... }:
{
  # Navigate to http://localhost:631/ to configure
  services.printing = {
    enable = true;
    browsing = true;
    allowFrom = [ "skynet" ];
    defaultShared = true;
  };

  networking.firewall.allowedUDPPorts = [ 631 ];
  networking.firewall.allowedTCPPorts = [ 631 ];
}
