# https://www.thingiverse.com/ksevelyar/likes
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # slicers
    prusa-slicer
    # cura

    # programmatic cads
    openscad
    openscad-lsp
    # required for openscad formatter
    clang-tools
    # libfive
  ];
}
