{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest
      elixir
      elixir_ls
      gcc

      # lsp
      rnix-lsp
      rustup
      rustfmt
      cargo
      rust-analyzer

      # tools
      zeal # docs
      curlie # api
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui
    ];
}
