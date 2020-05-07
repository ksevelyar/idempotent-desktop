{ lib, ... }:
{
  networking.firewall.enable = lib.mkForce true;
  networking.firewall.allowedTCPPorts = [
    # Transmission
    41414

    # VNC
    5900

    # Dev
    8080
    4040
  ];

  networking.firewall.allowedUDPPorts = [
    # Transmission
    41414

    # wireguard
    51820
  ];
}
