{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # rust
      rnix-lsp
      rustup
      rustfmt
      cargo
      rust-analyzer

      # elixir
      elixir
      elixir_ls

      # node
      nodejs_latest

      # lua
      luaformatter
      sumneko-lua-language-server

      # prettier
      efm-langserver

      # tools
      exercism
      gcc
      openssl
      curlie
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui
    ];

  environment.shellAliases = {
    mt = "mix test --max-failures=1";
  };
}
