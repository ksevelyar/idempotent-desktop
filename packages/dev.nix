{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs-14_x
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
