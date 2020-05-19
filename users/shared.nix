{ config, pkgs, vars, ... }:
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/${vars.user} && chown ${vars.user}:users /nix/var/nix/profiles/per-user/${vars.user}";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-${vars.user}.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  users.defaultUserShell = pkgs.fish;
  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Moscow";
  location.latitude = 55.75;
  location.longitude = 37.61;

  environment = {
    variables = {
      EDITOR = "nvim";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      programs.git = {
        enable = true;
        aliases = {
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
          recent-branches = "branch --sort=-committerdate";
        };
      };

      # home.extraBuilderCommands = "sed -i 's/| head -1)/| head -1 || true)/' $out/activate";

      home.file.".eslintrc.json".source = ../home/.eslintrc.json;
      home.file.".npmrc".source = ../home/.npmrc;

      # TODO: create module for Terminus
      home.file.".local/share/fonts/ter-u12n.otb".source = ../assets/fonts/ter-u12n.otb;
      home.file.".local/share/fonts/ter-u12b.otb".source = ../assets/fonts/ter-u12b.otb;
      home.file.".local/share/fonts/ter-u14n.otb".source = ../assets/fonts/ter-u14n.otb;
      home.file.".local/share/fonts/ter-u14b.otb".source = ../assets/fonts/ter-u14b.otb;
      home.file.".local/share/fonts/ter-u16n.otb".source = ../assets/fonts/ter-u16n.otb;
      home.file.".local/share/fonts/ter-u16b.otb".source = ../assets/fonts/ter-u16b.otb;
      home.file.".local/share/fonts/ter-u18n.otb".source = ../assets/fonts/ter-u18n.otb;
      home.file.".local/share/fonts/ter-u18b.otb".source = ../assets/fonts/ter-u18b.otb;
      home.file.".local/share/fonts/ter-u20n.otb".source = ../assets/fonts/ter-u20b.otb;
      home.file.".local/share/fonts/ter-u20b.otb".source = ../assets/fonts/ter-u20b.otb;
      home.file.".local/share/fonts/ter-u22n.otb".source = ../assets/fonts/ter-u22b.otb;
      home.file.".local/share/fonts/ter-u22b.otb".source = ../assets/fonts/ter-u22b.otb;
      home.file.".local/share/fonts/ter-u24n.otb".source = ../assets/fonts/ter-u24b.otb;
      home.file.".local/share/fonts/ter-u24b.otb".source = ../assets/fonts/ter-u24b.otb;
      home.file.".local/share/fonts/ter-u28n.otb".source = ../assets/fonts/ter-u28b.otb;
      home.file.".local/share/fonts/ter-u28b.otb".source = ../assets/fonts/ter-u28b.otb;
      home.file.".local/share/fonts/ter-u32n.otb".source = ../assets/fonts/ter-u32b.otb;
      home.file.".local/share/fonts/ter-u32b.otb".source = ../assets/fonts/ter-u32b.otb;

      # home.file.".config/nvim/init.vim".source = ../home/.config/nvim/init.vim;
      home.file.".config/nvim/coc-settings.json".source = ../home/.config/nvim/coc-settings.json;

      home.file.".config/fish/config.fish".source = ../home/.config/fish/config.fish;
      home.file.".config/fish/functions/git_aliases.fish".source = ../home/.config/fish/functions/git_aliases.fish;
      home.file.".config/fish/conf.d/z.fish".source = ../home/.config/fish/conf.d/z.fish;
      home.file.".config/fish/functions/fish_prompt.fish".source = ../home/.config/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../home/.config/fish/functions/fish_print_git_action.fish;
    };
  };
}
