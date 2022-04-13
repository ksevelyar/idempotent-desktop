{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # TODO: declarative deps for vim
    nodejs_latest # npm i -g eslint typescript typescript-language-server vls vscode-langservers-extracted
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
