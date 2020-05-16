{
  services.murmur = {
    enable = true;
    welcometext = "🥂";
    users = 50;
    registerName = "skynet";
    clientCertRequired = true;
    bandwhich = 100000;
  };

  networking.firewall.allowedTCPPorts = [ 64738 ];
  networking.firewall.allowedUDPPorts = [ 64738 ];
}
