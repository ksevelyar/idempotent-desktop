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
    openscad-unstable
    openscad-lsp
    # required for openscad formatter
    clang-tools
  ];
}
