{ config, pkgs, ... }:
{
  imports =
    [
      ./shared.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ksevelyar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/ksevelyar";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-ksevelyar.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  home-manager = {
    users.ksevelyar = {
      programs.git = {
        userName = "Sergey Zubkov";
        userEmail = "ksevelyar@gmail.com";
        enable = true;
        aliases.lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      home.file.".eslintrc.json".source = ../home/.eslintrc.json;
      home.file.".npmrc".source = ../home/.npmrc;


      home.file.".config/nvim/init.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../home/.config/nvim/coc-settings.json;

      home.file.".config/fish/config.fish".source = ../home/.config/fish/config.fish;
      home.file.".config/fish/fishfile".source = ../home/.config/fish/fishfile;
      home.file.".config/fish/functions/git_aliases.fish".source =
        ../home/.config/fish/functions/git_aliases.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source =
        ../home/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source =
        ../home/.config/fish/functions/fish_print_git_action.fish;
    };
  };
}
