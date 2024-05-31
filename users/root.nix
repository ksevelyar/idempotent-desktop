{
  home-manager = {
    useGlobalPkgs = true;
    users.root = {
      home.stateVersion = "24.05";
      home.file.".config/nvim/init.lua".source = ../users/shared/nvim/init.lua;

      home.file.".config/fish/config.fish".source = ../users/shared/fish/config.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/fish/functions/fish_print_git_action.fish;
    };
  };
}
