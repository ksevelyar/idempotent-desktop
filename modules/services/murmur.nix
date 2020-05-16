# nix eval --raw -f '<nixpkgs/nixos>' config.systemd.services.murmur.serviceConfig.ExecStart

{
  services.murmur = {
    enable = true;
    welcometext = "🥂";
    users = 50;
    registerName = "skynet";
    clientCertRequired = true;
    bandwidth = 100000;
  };

  networking.firewall.allowedTCPPorts = [ 64738 ];
  networking.firewall.allowedUDPPorts = [ 64738 ];
}
