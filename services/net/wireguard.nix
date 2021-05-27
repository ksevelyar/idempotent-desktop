{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      wireguard
    ];

  networking.wireguard.interfaces = {
    skynet = {
      peers = [
        {
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";
          allowedIPs = [ "192.168.42.0/24" ];
          endpoint = "95.165.99.133:51821";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
