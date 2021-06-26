{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      python
      nodejs_latest
      elixir
      elixir_ls
      gcc

      # lsp
      rnix-lsp
      clang-tools

      # tools
      zeal # docs
      curlie # api
      imagemagick
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui
    ];
}
