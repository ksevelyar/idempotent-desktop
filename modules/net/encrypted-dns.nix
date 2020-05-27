{ lib, ... }:
{
  # No matter what proxy you use, you should set your DNS nameservers statically and make sure that your network manager won't override your carefully set nameservers with some random settings it received over DHCP. 
  services.resolved.enable = false;

  networking = {
    nameservers = [ "::1" ];
    resolvconf.enable = lib.mkForce false;
    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };

  services.kresd = {
    enable = true;
    extraConfig = ''
      policy.add(policy.all(policy.TLS_FORWARD({
        { '2620:fe::fe', hostname = 'dns.quad9.net', ca_file = '/etc/ssl/certs/ca-bundle.crt' },
      })))
    '';
  };
}
