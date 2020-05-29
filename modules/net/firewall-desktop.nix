{ lib, ... }:
{
  # No matter what proxy you use, you should set your DNS nameservers statically and make sure that your network manager won't override your carefully set nameservers with some random settings it received over DHCP. 
  # https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Public+Resolvers#DNSPrivacyPublicResolvers-DNS-over-TLS(DoT)
  networking.resolvconf.useLocalResolver = true;
  services.kresd = {
    enable = true;
    extraConfig = ''
      cache.size = 100 * MB
      
      policy.add(policy.all(policy.TLS_FORWARD({
      { '9.9.9.10', hostname = 'dns.quad9.net' },
      { '176.103.130.136', hostname = 'dns.adguard.com' },
      { '185.228.169.9', hostname = 'security-filter-dns.cleanbrowsing.org' },
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
  ];
}
