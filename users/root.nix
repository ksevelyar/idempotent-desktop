{
  home-manager = {
    useGlobalPkgs = true;
    users.root = {
      home.file.".config/nvim/init.vim".source = ../users/shared/nvim/init.vim;
      home.file.".config/nvim/lua/config.lua".source = ../users/shared/nvim/lua/config.lua;

      home.file.".config/fish/config.fish".source = ../users/shared/fish/config.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/fish/functions/fish_print_git_action.fish;
    };
  };
}
