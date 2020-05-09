{ config, pkgs, ... }:
# let
#   user = "ksevelyar";
#   userName = config.users.users."${user}".name;
#   home = config.users.users."${user}".home;
#   fontSize = 14;
#
#   startupBanner = pkgs.fetchurl {
#     url = "https://github.com/NixOS/nixos-homepage/raw/master/logo/nix-wiki.png";
#     sha256 = "1hrz7wr7i0b2bips60ygacbkmdzv466lsbxi22hycg42kv4m0173";
#   };
# in
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  # systemd.services =
  #   let
  #     clone =
  #       repository: folder: branch:
  #         {
  #           enable = true;
  #           wantedBy = [ "multi-user.target" ];
  #           description = "clone ${repository} to ${folder}";
  #           serviceConfig.User = userName;
  #           unitConfig.ConditionPathExists = "!${folder}";
  #           script = ''
  #             ${pkgs.git}/bin/git clone ${repository} --branch ${branch} ${folder}
  #           '';
  #         };
  #   in
  #     {
  #       emacs-pull = clone "https://github.com/syl20bnr/spacemacs" "${home}/.emacs.d" "master";
  #     };

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
  };
}
