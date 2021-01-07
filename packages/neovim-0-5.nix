self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "master";
    src = builtins.fetchGit {
      url = https://github.com/neovim/neovim.git;
    };
    nativeBuildInputs = super.neovim-unwrapped.nativeBuildInputs ++ [ super.tree-sitter ];
  });
}
