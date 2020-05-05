{ lib, ... }:
{
  networking.firewall.enable = lib.mkForce true;
  networking.firewall.allowedTCPPorts = [
    # Transmission
    41414

    # VNC
    5900

    # NFS
    111 # portmapper
    2049
    20000
    20001
    20002

    # Dev
    8080
    4040
  ];

  networking.firewall.allowedUDPPorts = [
    # Transmission
    41414

    # NFS
    111 # portmapper
    2049
    20000
    20001
    20002

    # wireguard
    51820
  ];

}
