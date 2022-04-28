{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    configure = {
      customRC = builtins.readFile ../users/shared/.config/nvim/init.vim;
    };
  };

  environment.systemPackages = with pkgs; [
    # nix
    rnix-lsp

    # elixir
    elixir_ls

    # rust
    rustfmt

    # lua
    efm-langserver
    luaformatter
    sumneko-lua-language-server

    nodejs_latest
  ];

  # TODO: declarative deps for vim
  environment.shellAliases = {
    install-vim-deps = "npm i -g vim-language-server typescript typescript-language-server eslint vscode-langservers-extracted";
  };
}
