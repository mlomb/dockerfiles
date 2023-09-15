#! /bin/sh
set -eu

date

echo "Backing up Postgres..."

PG_HOST_OPTS="--username=$POSTGRES_USER --host=$POSTGRES_HOST --port=$POSTGRES_PORT"
databases=$DATABASES

for database in $databases
do
    echo "Database: $database"
    PGPASSWORD="$POSTGRES_PASSWORD" pg_dump --inserts --column-inserts $PG_HOST_OPTS $database \
      | gzip \
      > $TARGET_FOLDER/$database_$(date +"%Y-%m-%d").sql.gz
done

echo "Done."