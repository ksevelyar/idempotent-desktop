{
  nix = {
    settings = {
      substituters = [
        "https://idempotent-desktop.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "idempotent-desktop.cachix.org-1:21i2Mb/mrJ9XcfmksWpaYMr78ZPbwxhX/BwSS1X+PRw="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
