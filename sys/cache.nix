{ config, pkgs, ... }:
{
  nix = {
    settings = {
      substituters = [
        "https://idempotent-desktop.cachix.org"
      ];
      trusted-public-keys = [
        "idempotent-desktop.cachix.org-1:OkWDud90b2/k/k1yIUg1lxZdNRWEvCfv6zSSRQ75lVM="
      ];
    };
  };
}
