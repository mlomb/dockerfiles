#! /bin/sh
set -eu

# reset cron
rm /etc/crontabs/root
echo "${CRON_SCHEDULE} /backup.sh" > /etc/crontabs/root

crond -f -d 8