{ config, pkgs, ... }:
{
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
