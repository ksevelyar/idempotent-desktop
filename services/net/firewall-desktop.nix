{ lib, ... }:
{
  systemd.services.sshd.wantedBy = lib.mkForce []; # sudo systemctl start sshd

  networking.firewall.enable = lib.mkForce true;

  networking.firewall.allowedTCPPorts = [
    # Transmission
    41414

    # VNC
    5900

    # Dev
    3000
    4000
    8080
    4040
  ];

  networking.firewall.allowedUDPPorts = [
    # Transmission
    41414
  ];
}
