{ config, pkgs, ... }:
{
  # hide 'warning: system.stateVersion is not set'
  # doesn't affect anything because of flakes
  system.stateVersion = "9000";

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      sandbox = true;
    };

    # 🍑 smooth rebuilds
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 4; # 7 max

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      connect-timeout = 5
    '';
  };
}
