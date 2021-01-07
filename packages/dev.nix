{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest
      elixir
      gcc

      # lsp
      rnix-lsp
      clang-tools

      # tools
      zeal # docs
      curlie # api
      imagemagick
      universal-ctags
      global
      direnv
      lorri
      inotify-tools
      gitg
      gitAndTools.gitui
    ];
}
