{
  services.murmur = {
    enable = true;
    welcometext = "🥂";
  };

  networking.firewall.allowedTCPPorts = [ 64738 ];
  networking.firewall.allowedUDPPorts = [ 64738 ];
}
