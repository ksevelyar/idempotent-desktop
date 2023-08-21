{ lib, ... }:
{
  services.openvpn.servers = {
    uk-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/uk-lon.prod.surfshark.com_tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    de-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/de-ber.prod.surfshark.com_tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    fr-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/fr-mrs.prod.surfshark.com_tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    es-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/es-mad.prod.surfshark.com_tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    br-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/br-sao.prod.surfshark.com_tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    kaz-shark = {
      config = '' config /etc/nixos/services/vpn/surfshark/kz-ura.prod.surfshark.com_tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    us-proton = {
      config = '' config /etc/nixos/services/vpn/proton/us-free-01.protonvpn.com.tcp.ovpn '';
      autoStart = lib.mkDefault false;
      updateResolvConf = true;
    };
    express = {
      config = '' config /etc/nixos/services/vpn/express/express.tcp.ovpn '';
      autoStart = false;
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

        { command = "/run/current-system/sw/bin/systemctl start openvpn-express.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop openvpn-express.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl restart openvpn-express.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl status openvpn-expresss.service"; options = [ "SETENV" "NOPASSWD" ]; }

        { command = "/run/current-system/sw/bin/systemctl start openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl restart openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl status openvpn-fr-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }

        { command = "/run/current-system/sw/bin/systemctl start openvpn-de-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop openvpn-de-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl restart openvpn-de-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl status openvpn-de-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }

        { command = "/run/current-system/sw/bin/systemctl start openvpn-br-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop openvpn-br-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl restart openvpn-br-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl status openvpn-br-shark.service"; options = [ "SETENV" "NOPASSWD" ]; }
      ];
    }
  ];
}
