#! /bin/sh
set -eu

date

echo "Backing up Redis..."
echo "Copying RDB file..."

# Why just copying dump.rdb is correct
# https://stackoverflow.com/a/11184125

TMP_OUT=/tmp/dump.rdb
if [[ -z "${REDIS_PASSWORD}" ]]; then
  redis-cli -h $REDIS_HOST -p $REDIS_PORT --rdb $TMP_OUT
else
  redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASSWORD --rdb $TMP_OUT
fi

echo "Uploading RDB..."

cat $TMP_OUT \
  | gzip \
  | curl -X POST \
    -H "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
    -H "Dropbox-API-Arg: {\"path\": \"/$DROPBOX_FILEPATH.rdb.gz\",\"mode\": \"overwrite\"}" \
    -H "Content-Type: application/octet-stream" \
    -T - \
    --silent \
    --output /dev/null \
    https://content.dropboxapi.com/2/files/upload

rm $TMP_OUT

echo "Done."