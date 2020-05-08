{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest

      # <CTRL+T> list files+folders in current directory (e.g., git commit <CTRL+T>, select a few files using <TAB>, finally <Return>)
      # <CTRL+R> search history of shell commands
      # <ALT+C> fuzzy change directory
      fzf

      ripgrep
      universal-ctags
      global
      (
        neovim.override {
          vimAlias = true;
          viAlias = true;
          configure = {
            # packages.myPlugins = with pkgs.vimPlugins; {
            #   start = [ vim-plug ];
            #   opt = [];
            # };

            customRC = builtins.readFile ../../home/.config/nvim/init.vim;
          };
        }
      )
    ];
}
