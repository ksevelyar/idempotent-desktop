{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      wireguard-tools # sudo wg show
    ];
}
