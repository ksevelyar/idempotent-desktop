{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      global
      universal-ctags
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
