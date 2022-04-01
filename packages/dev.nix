{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # rust
      rnix-lsp
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
      gcc
      openssl
      curlie
      direnv
      inotify-tools
      gitg
    ];

  environment.shellAliases = {
    mt = "mix test --max-failures=1";
  };
}
