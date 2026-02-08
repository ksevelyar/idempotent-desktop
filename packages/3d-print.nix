{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # https://github.com/OrcaSlicer/OrcaSlicer/wiki/Calibration
    orca-slicer
    openscad-unstable
    openscad-lsp
  ];
}
