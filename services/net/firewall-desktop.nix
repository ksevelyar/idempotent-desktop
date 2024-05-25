{lib, ...}: {
  networking.firewall.enable = lib.mkForce true;

  networking.firewall.allowedTCPPorts = [
    # Transmission
    41414

    # VNC
    5900
  ];

  networking.firewall.allowedUDPPorts = [
    # Transmission
    41414
  ];
}
