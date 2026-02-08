{
  config,
  pkgs,
  ...
}: {
  nix = {
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
