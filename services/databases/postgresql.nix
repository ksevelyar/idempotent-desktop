{pkgs, ...}: let
  hunspell_ru_ru = pkgs.postgresql_17.pkgs.callPackage (
    {
      postgresqlBuildExtension,
      fetchgit,
      postgresql,
    }:
      postgresqlBuildExtension {
        pname = "hunspell_ru_ru";
        version = "unstable-2019";

        src = fetchgit {
          url = "https://github.com/postgrespro/hunspell_dicts";
          rev = "918f8d093b1b6cd5f7e4c6b4874f559d7210b207";
          hash = "sha256-ht7tpDtYEJMrQh2yBmWVbFFFQkInALBtuqRmcVaRbFw=";
        };

        sourceRoot = "hunspell_dicts-918f8d0/hunspell_ru_ru";
        makeFlags = ["USE_PGXS=1"];
      }
  ) {};
in {
  services.postgresql = {
    package = pkgs.postgresql_17;
    enable = true;
    authentication = ''
      local all all trust
      host all all localhost trust
    '';

    extensions = with pkgs.postgresql17Packages; [
      hunspell_ru_ru
      rum
      postgis
    ];
  };
}
