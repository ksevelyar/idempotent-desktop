{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # lsp
    ## nix
    nil
    alejandra

    ## lua
    gcc
    lua-language-server

    ## css + html + js
    vscode-langservers-extracted
    superhtml
    typescript-language-server
  ];
}
