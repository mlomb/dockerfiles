#! /bin/sh
set -eu

date

echo "Backing up MySQL..."

MYSQL_HOST_OPTS="-h $MYSQL_HOST -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD"
databases=$(mysql $MYSQL_HOST_OPTS -e 'SHOW DATABASES;' --silent)

for database in $databases
do
  if [ "$database" != "information_schema" ] || [ "$database" != "performance_schema" ]
  then
    echo "Database: $database"
    mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $database \
      | gzip \
      | curl -X PUT \
             -H "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
             -T - \
             --output /dev/null \
             https://content.dropboxapi.com/1/files_put/auto/$DROPBOX_FILEPATH.sql.gz
             #--silent \
  fi
done
