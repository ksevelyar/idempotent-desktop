{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./neovim-0-5.nix)
  ];

  environment.systemPackages = with pkgs;
    [
      (
        neovim.override {
          vimAlias = true;
          viAlias = true;
          configure = {
            customRC = builtins.readFile ../users/shared/.config/nvim/init.vim;
          };
        }
      )
    ];
}
