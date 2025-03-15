{
  config,
  pkgs,
  ...
}: {
  system.stateVersion = "25.05";

  documentation.man.generateCaches = false;

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
