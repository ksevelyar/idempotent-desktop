{ lib, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  networking.useDHCP = false;

  networking.interfaces = {
    enp3s0.useDHCP = true;
    enp5s0.ipv4.addresses = [{ address = "192.168.0.1"; prefixLength = 24; }];
  };

  networking.firewall = {
    enable = lib.mkForce true;

    interfaces.enp3s0 = {
      allowedTCPPorts = [
        41414
        # http, https
        80
        443
      ];
      allowedUDPPorts = [
        41414
        # wireguard
        51820
      ];
    };

    interfaces.enp5s0 = {
      allowedTCPPorts = [
        41414
        # http, https
        80
        443
      ];
      allowedUDPPorts = [
        41414
        # wireguard
        51820
        # dns cache
        53
      ];
    };
  };

  networking.nat = {
    enable = true;
    externalInterface = "enp3s0";
    internalInterfaces = [ "enp5s0" ];

    forwardPorts = [
      { sourcePort = 41414; destination = "192.168.0.47:41414"; proto = "tcp"; }
      { sourcePort = 41414; destination = "192.168.0.47:41414"; proto = "udp"; }

      { sourcePort = 11786; destination = "192.168.0.47:11786"; proto = "tcp"; }
      { sourcePort = 11786; destination = "192.168.0.47:11786"; proto = "udp"; }
    ];
  };

  # https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Public+Resolvers#DNSPrivacyPublicResolvers-DNS-over-TLS(DoT)
  services.kresd = {
    enable = true;
    listenPlain = [ "[::1]:53" "127.0.0.1:53" "192.168.0.1:53" ];
    extraConfig = ''
      cache.size = 100 * MB

      policy.add(policy.all(policy.TLS_FORWARD({
      { '9.9.9.9', hostname = 'dns.quad9.net' },
      { '176.103.130.131', hostname = 'dns.adguard.com' },
      })))
    '';
  };

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
