{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest
      openssl
      elixir
      elixir_ls
      exercism
      gcc

      # lsp
      sumneko-lua-language-server
      efm-langserver
      rnix-lsp
      rustup
      rustfmt
      cargo
      rust-analyzer

      # tools
      curlie
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui
    ];
}
