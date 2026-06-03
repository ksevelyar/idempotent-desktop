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
      connect-timeout = 20;
      stalled-download-timeout = 20;
      fallback = true;

      # FIXME: blocked
      # extra-substituters = [
      #   "https://idempotent-desktop.cachix.org"
      # ];
      # extra-trusted-public-keys = [
      #   "idempotent-desktop.cachix.org-1:21i2Mb/mrJ9XcfmksWpaYMr78ZPbwxhX/BwSS1X+PRw="
      # ];
    };
  };
}
