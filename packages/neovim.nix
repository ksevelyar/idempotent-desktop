{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovim
    # nix
    nil
    alejandra

    # lua
    gcc
    sumneko-lua-language-server

    nodejs_latest
  ];

  # TODO: declarative deps for vim
  environment.shellAliases = {
    install-neovim-deps = "npm i -g typescript typescript-language-server eslint vscode-langservers-extracted";
  };
}
