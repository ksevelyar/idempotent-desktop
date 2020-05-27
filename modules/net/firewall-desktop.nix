{ lib, ... }:
{
  # No matter what proxy you use, you should set your DNS nameservers statically and make sure that your network manager won't override your carefully set nameservers with some random settings it received over DHCP. 
  networking.resolvconf.useLocalResolver = true;
  services.kresd = {
    enable = true;
    extraConfig = ''
      cache.size = 100 * MB
      
      policy.add(policy.all(policy.TLS_FORWARD({
      { '9.9.9.9', hostname = 'dns.quad9.net' },
      })))
    '';
  };

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

    # wireguard
    51820
  ];
}
