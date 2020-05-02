{
  networking.useDHCP = false;

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

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "enp5s0" ];
    extraConfig = ''
      option subnet-mask 255.255.255.0;
      option broadcast-address 192.168.0.255;
      option domain-name-servers 8.8.8.8, 4.4.4.4;
      option routers 192.168.0.1;
      subnet 192.168.0.0 netmask 255.255.255.0 {
        range 192.168.0.100 192.168.0.200;
      }
    '';
  };
}
