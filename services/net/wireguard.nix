{ config, pkgs, ... }:
{
  # mkdir -p ~/.secrets/wireguard && cd ~/.secrets/wireguard && umask 077
  # wg genkey | tee private | wg pubkey > public
  environment.systemPackages = with pkgs;
    [
      wireguard-tools # sudo wg show
    ];
}
