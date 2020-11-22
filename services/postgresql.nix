{ pkgs, vars, ... }:
let
  id-pg-backup = pkgs.writeScriptBin "id-pg-backup" ''
    #!${pkgs.stdenv.shell}
    set -e
    
    backup_dir="/home/${vars.user}/.backup/pg"
    excludes='template1 template0'

    # list of all dbs
    databases="$(psql -At -c 'select datname from pg_database postgres' postgres)"

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
      pg_dump --format=custom --compress=9 --clean --no-privileges --no-owner \
              --file=$backup_dir/$database/$database-$(date +%Y-%m-%d-%H-%M).sql \
              $database
    done

    du -h --max-depth=1 $backup_dir 
  '';
in
{
  services.postgresql = {
    package = pkgs.postgresql_12;
    enable = true;
    authentication = ''
      local all all trust
      host all all localhost trust
    '';
    ensureUsers = [
      {
        name = "postgres";
        ensurePermissions = {
          "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  environment.systemPackages = [
    # pkgs.sequeler
    id-pg-backup
  ];
}
