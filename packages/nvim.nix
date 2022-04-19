{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_latest
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

  # TODO: declarative deps for vim
  environment.shellAliases = {
    install-vim-deps = "npm i -g vim-language-server typescript typescript-language-server eslint vscode-langservers-extracted";
  };
}
