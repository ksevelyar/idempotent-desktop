#!/bin/bash

# backups dir
backup_path="/storage/backup/postgresql"

# excludes from backup
db_exclude='template1 template0'

# list of all dbs
databases="$(sudo -u postgres psql -At -c 'select datname from pg_database postgres')"

# clean list from excludes
for exclude in $db_exclude; do
  databases=$(echo $databases | sed "s/\b$exclude\b//g")
done

# backup
sudo mkdir -p $backup_path
sudo chown postgres:postgres $backup_path

for database in $databases; do
  echo $database...

  sudo -u postgres mkdir -p $backup_path/$database
  sudo -u postgres pg_dump --format=custom \
                           --compress=9    \
                           --clean         \
                           --no-privileges \
                           --no-owner \
                           --file=$backup_path/$database/$database.$(date +%Y-%m-%d-%H-%M).sql \
                           $database
done

# rm old backups
find $backup_path -mtime +31 -delete
