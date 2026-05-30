{pkgs, ...}: {
  system.stateVersion = "25.05";

  documentation.enable = false;
  documentation.man.generateCaches = false;

  nix = {
    package = pkgs.nixVersions.stable;
    settings.sandbox = true;

    # NOTE: 🍑 smooth rebuilds
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 7;

    settings = {
      experimental-features = ["nix-command" "flakes"];

      # NOTE: fail curl after 5 seconds, rebuild from source if fetching cache fails
      connect-timeout = 5;
      stalled-download-timeout = 5;
      fallback = true;
    };
  };
}
