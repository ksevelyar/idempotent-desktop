{ lib, ... }:
{
  networking.firewall.enable = lib.mkForce true;
  networking.firewall.allowedTCPPorts = [
    # Transmission
    51413

    # VNC
    5900

    # NFS
    111
    2049
    20000
    20001
    20002

    # Dev
    8080
  ];

  networking.firewall.allowedUDPPorts = [ 51413 5900 111 2049 20000 20001 20002 8080 4242 ];
}
