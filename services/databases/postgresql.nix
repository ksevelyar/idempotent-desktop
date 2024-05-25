{pkgs, ...}: let
  pg-backup = pkgs.writeScriptBin "pg-backup" ''
    #!${pkgs.stdenv.shell}
    set -e

    backup_dir="~/.backup/pg"
    excludes='template1 template0'

    # list of all dbs
    databases="$(psql -U postgres -At -c 'select datname from pg_database postgres' postgres)"

    # clean list from excludes
    for exclude in $excludes; do
      databases=$(echo $databases | sed "s/\b$exclude\b//g")
    done

    # backup
    mkdir -p $backup_dir

    for database in $databases; do
      dump_name=$backup_dir/$database/$database-$(date +%Y-%m-%d-%H-%M).sql
      echo $dump_name

      mkdir -p $backup_dir/$database
      pg_dump -U postgres --format=custom --compress=9 --clean --no-privileges --no-owner \
              --file=$backup_dir/$database/$database-$(date +%Y-%m-%d-%H-%M).sql \
              $database
    done

    du -h --max-depth=1 $backup_dir
  '';
in {
  services.postgresql = {
    package = pkgs.postgresql_13;
    enable = true;
    authentication = ''
      local all all trust
      host all all localhost trust
    '';
  };

  environment.systemPackages = [
    pg-backup
  ];
}
