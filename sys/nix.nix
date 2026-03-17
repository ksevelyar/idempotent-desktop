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

    extraOptions = ''
      experimental-features = nix-command flakes
      connect-timeout = 5
    '';

    settings = {
      substituters = [
        "https://idempotent-desktop.cachix.org"
      ];
      trusted-public-keys = [
        "idempotent-desktop.cachix.org-1:21i2Mb/mrJ9XcfmksWpaYMr78ZPbwxhX/BwSS1X+PRw="
      ];
    };
  };
}
