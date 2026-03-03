{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim-unwrapped
    # nix
    nil
    alejandra

    # lua
    gcc
    lua-language-server

    superhtml
    # nodejs_latest

    # llm
    # codex-acp
  ];

  # TODO: declarative deps for vim
  environment.shellAliases = {
    install-neovim-deps = "npm i -g typescript typescript-language-server eslint vscode-langservers-extracted";
  };
}
