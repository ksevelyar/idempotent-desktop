{pkgs, ...}: {
  system.stateVersion = "25.05";

  documentation.enable = false;
  documentation.man.cache.enable = false;

  nix = {
    package = pkgs.nixVersions.stable;

    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 7;

    settings = {
      experimental-features = ["nix-command" "flakes"];

      # NOTE: fail curl after 5 seconds, rebuild from source if fetching cache fails
      connect-timeout = 5;
      stalled-download-timeout = 5;
      fallback = true;

      substituters = [
        "https://idempotent-desktop.cachix.org"
      ];
      trusted-public-keys = [
        "idempotent-desktop.cachix.org-1:21i2Mb/mrJ9XcfmksWpaYMr78ZPbwxhX/BwSS1X+PRw="
      ];
    };
  };
}
