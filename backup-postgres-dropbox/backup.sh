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
      | curl -X POST \
        -H "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
        -H "Dropbox-API-Arg: {\"path\": \"/$DROPBOX_FILEPATH.sql.gz\",\"mode\": \"overwrite\"}" \
        -H "Content-Type: application/octet-stream" \
        -T - \
        --silent \
        --output /dev/null \
        https://content.dropboxapi.com/2/files/upload
done

echo "Done."