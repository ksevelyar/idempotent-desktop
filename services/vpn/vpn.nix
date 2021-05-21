{
  services.openvpn.servers = {
    uk-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/uk-lon.prod.surfshark.com_udp.ovpn '';
      autoStart = true;
      updateResolvConf = true;
    };
    us-proton = {
      config = '' config /etc/nixos/services/vpn/proton/us-free-01.protonvpn.com.tcp.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
}
