{
  nixpkgs.config.allowUnfree = true;
  # NOTE: enable spotify & netflix
  nixpkgs.config.chromium.enableWideVine = true;

  hardware.wirelessRegulatoryDatabase = true;
}
