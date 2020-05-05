{ lib, ... }:
{
  networking.useDHCP = false;

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
  networking.firewall.allowedUDPPorts = [ 51413 5900 111 2049 20000 20001 20002 8080 51820 ];

  networking.nat.enable = true;
  networking.nat.externalInterface = "enp3s0";
  networking.nat.internalInterfaces = [ "enp5s0" ];

  networking.interfaces.enp3s0.useDHCP = true;
  networking.interfaces.enp5s0.ipv4.addresses = [
    {
      address = "192.168.0.1";
      prefixLength = 24;
    }
  ];

  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    domain-needed
    bogus-priv
    no-resolv

    server=208.67.220.220
    server=8.8.4.4
    
    listen-address=::1,127.0.0.1,192.168.0.1
    bind-interfaces
    
    cache-size=10000
    log-queries
    log-facility=/tmp/ad-block.log
    local-ttl=300

    conf-file=/etc/nixos/assets/hosts-blocklists/domains.txt
    addn-hosts=/etc/nixos/assets/hosts-blocklists/hostnames.txt
  '';

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "enp5s0" ];
    extraConfig = ''
      option subnet-mask 255.255.255.0;
      option broadcast-address 192.168.0.255;
      option domain-name-servers 192.168.0.1;
      option routers 192.168.0.1;
      subnet 192.168.0.0 netmask 255.255.255.0 {
        range 192.168.0.100 192.168.0.200;
      }
    '';
  };

  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.1" ];
      listenPort = 51820;

      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        # laundry
        {
          publicKey = "Ql36tqX82moc8k5Yx4McF2zxF4QG3jeoXoj8AxSUNRU=";
          allowedIPs = [ "192.168.42.2" ];
        }

        # pepes
        {
          publicKey = "dKznTEMMN4xKXuP8UDo92G14pzwrJNGTISeSXoMcTxQ=";
          allowedIPs = [ "192.168.42.3" ];
        }

        # # cyberdemon
        # {
        #   publicKey = "hru";
        #   allowedIPs = [ "192.168.42.4" ];
        # }
      ];
    };
  };
}
