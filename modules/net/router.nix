{ lib, ... }:
{
  networking.useDHCP = false;

  networking.interfaces = {
    enp3s0.useDHCP = true;
    enp5s0.ipv4.addresses = [ { address = "192.168.0.1"; prefixLength = 24; } ];
  };

  networking.firewall = {
    enable = lib.mkForce true;
    allowedTCPPorts = [
      # Transmission
      41414

      # NFS
      111 # portmapper
      2049
      20000
      20001
      20002

      # http
      80

      # https
      443
    ];
    allowedUDPPorts = [
      # Transmission
      41414

      # wireguard
      51820

      # dnsmasq
      53
    ];
  };

  networking.nat = {
    enable = true;
    externalInterface = "enp3s0";
    internalInterfaces = [ "enp5s0" ];

    forwardPorts = [
      { sourcePort = 41414; destination = "192.168.0.47:41414"; proto = "tcp"; }
      { sourcePort = 41414; destination = "192.168.0.47:41414"; proto = "udp"; }
    ];
  };

  # mkdir -p ~/wireguard-keys && cd ~/wireguard-keys && umask 077
  # wg genkey | tee private | wg pubkey > public
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.1" ];
      listenPort = 51820;

      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        # HK-47
        {
          publicKey = "Ql36tqX82moc8k5Yx4McF2zxF4QG3jeoXoj8AxSUNRU=";
          allowedIPs = [ "192.168.42.47" ];
        }

        # pepes
        {
          publicKey = "dKznTEMMN4xKXuP8UDo92G14pzwrJNGTISeSXoMcTxQ=";
          allowedIPs = [ "192.168.42.3" ];
        }

        # cyberdemon
        {
          publicKey = "3DUHA0EYOaFVjeemwvqYa3wtbLDAc4wPhrPVnXxsdQ0=";
          allowedIPs = [ "192.168.42.4" ];
        }
      ];
    };
  };

  # https://github.com/notracking/hosts-blocklists
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    domain-needed
    bogus-priv
    no-resolv

    server=208.67.220.220
    server=1.1.1.1
    
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

    machines = [
      { hostName = "hk47"; ethernetAddress = "a8:5e:45:57:51:d0"; ipAddress = "192.168.0.47"; }
    ];
  };
}
