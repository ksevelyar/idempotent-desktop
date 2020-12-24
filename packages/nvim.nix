{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest # coc.nvim dep
      fzf
      ripgrep
      universal-ctags
      global

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
