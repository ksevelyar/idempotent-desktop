{ config, pkgs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    useSandbox = true;

    binaryCaches = [
      "https://idempotent-desktop.cachix.org"
    ];
    binaryCachePublicKeys = [
      "idempotent-desktop.cachix.org-1:OkWDud90b2/k/k1yIUg1lxZdNRWEvCfv6zSSRQ75lVM="
    ];

    # 🍑 smooth rebuilds
    daemonNiceLevel = 2; # 19 max
    daemonIONiceLevel = 2; # 7 max

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # free up to 20GiB whenever there is less than 5GB left: 
    extraOptions = ''
      experimental-features = nix-command flakes
      connect-timeout = 5 
      min-free = ${toString (5 * 1024 * 1024 * 1024)}
      max-free = ${toString (20 * 1024 * 1024 * 1024)}
    '';
  };
}
