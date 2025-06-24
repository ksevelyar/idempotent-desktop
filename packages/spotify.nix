{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      spotify
      playerctl
    ];
  };

  networking.firewall.allowedTCPPorts = [57621];
  networking.firewall.allowedUDPPorts = [5353];
}
