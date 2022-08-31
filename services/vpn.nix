{ lib, ... }:
{
  services.openvpn.servers = {
    uk-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/uk-lon.prod.surfshark.com_udp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    de-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/de-ber.prod.surfshark.com_udp.ovpn '';
      autoStart = lib.mkDefault true;
      updateResolvConf = true;
    };
    fr-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/fr-par.prod.surfshark.com_udp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    us-proton = {
      config = '' config /etc/nixos/services/vpn/proton/us-free-01.protonvpn.com.tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        { command = "/run/current-system/sw/bin/systemctl start openvpn-uk-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop openvpn-uk-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl restart openvpn-uk-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl status openvpn-uk-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }

        { command = "/run/current-system/sw/bin/systemctl start openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl restart openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl status openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
      ];
    }
  ];
}
