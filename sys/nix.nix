{
  config,
  pkgs,
  lib,
  ...
}: {
  system.stateVersion = "25.05";

  documentation.enable = false;
  documentation.man.generateCaches = false;
  programs.command-not-found.enable = true;

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
