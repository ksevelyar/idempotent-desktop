{
  config,
  pkgs,
  ...
}: {
  # hide 'warning: system.stateVersion is not set'
  # doesn't affect anything because of flakes
  system.stateVersion = "9000";

  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      sandbox = true;
    };

    # 🍑 smooth rebuilds
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 4; # 7 max

    extraOptions = ''
      experimental-features = nix-command flakes
      connect-timeout = 5
    '';
  };
}
