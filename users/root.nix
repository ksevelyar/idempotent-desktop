{
  home-manager = {
    useGlobalPkgs = true;
    users.root = {
      imports = [
        ./shared/aliases.nix
        ./shared/neovim.nix
        ./shared/pi.nix
      ];

      home.stateVersion = "26.05";

      programs.fish = {
        enable = true;
        interactiveShellInit = builtins.readFile ./shared/fish/config.fish;
      };
      home.file.".config/fish/functions/fish_prompt.fish".source = ./shared/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ./shared/fish/functions/fish_print_git_action.fish;
    };
  };
}
