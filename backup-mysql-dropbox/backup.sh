#! /bin/sh
set -eu

date

echo "Backing up MySQL..."

MYSQL_HOST_OPTS="-h $MYSQL_HOST -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD"
databases=$DATABASES

for database in $databases
do
    echo "Database: $database"
    mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $database \
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