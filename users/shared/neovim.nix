{
  lib,
  pkgs,
  ...
}: let
  joker-vim = pkgs.vimUtils.buildVimPlugin {
    name = "joker-vim";
    src = pkgs.fetchFromGitHub {
      owner = "ksevelyar";
      repo = "joker.vim";
      rev = "main";
      sha256 = "sha256-T7r8iDHr8hcVRNnozEqdq9Sl6VFXbQ8IWpRMWGEZBE4=";
    };
  };
  direnv-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "direnv-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "NotAShelf";
      repo = "direnv.nvim";
      rev = "main";
      sha256 = "sha256-b5PpmkYWaDGLNcu+36tRR5ycATHYBjs9WrV8/jfmooQ=";
    };
  };
in {
  home.packages = with pkgs; [
    nil
    alejandra
    gcc
    lua-language-server
    vscode-langservers-extracted
    superhtml
    typescript-language-server
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = builtins.readFile ./nvim/init.lua;

    plugins = with pkgs.vimPlugins;
      lib.mkDefault [
        direnv-nvim

        indent-blankline-nvim
        lualine-nvim
        nvim-web-devicons

        telescope-nvim
        plenary-nvim
        nvim-tree-lua
        leap-nvim

        vim-fugitive
        gitsigns-nvim

        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-vsnip
        vim-vsnip

        nvim-treesitter.withAllGrammars
        nvim-colorizer-lua
        vim-openscad

        joker-vim
        oxocarbon-nvim
      ];
  };
}
