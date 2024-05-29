{
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    configure = {
      customRC = builtins.readFile ../users/shared/nvim/init.vim;
    };
  };

  environment.systemPackages = with pkgs; [
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
