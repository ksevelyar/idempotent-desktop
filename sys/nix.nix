{ config, pkgs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      sandbox = true;
    };

    # 🍑 smooth rebuilds
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 2; # 7 max

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
