{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    orca-slicer
    openscad-unstable
    openscad-lsp
  ];
}
