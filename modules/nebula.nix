{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs;
    [
      nebula
    ];

  networking.firewall.allowedUDPPorts = [ 4242 ];

  environment.shellAliases = {
    nebula-lighthouse = "tmux new-session -A -s nebula sudo nebula -config /etc/nebula/lighthouse.yml";
    nebula-node = "tmux new-session -A -s nebula sudo nebula -config /etc/nebula/node.yml";
  };
}
