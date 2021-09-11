FROM alpine:edge

RUN apk update
RUN apk add mysql-client curl

ENV MYSQLDUMP_OPTIONS --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384
ENV MYSQL_HOST ""
ENV MYSQL_PORT 3306
ENV MYSQL_USER "root"
ENV MYSQL_PASSWORD ""
ENV DROPBOX_FILE "database"
ENV DROPBOX_ACCESS_TOKEN ""
ENV CRON_SCHEDULE "0 0 * * *"

RUN echo "$CRON_SCHEDULE /backup.sh" > /etc/crontabs/root
COPY backup.sh backup.sh

CMD ["crond", "-f", "-d", "8", ">", "/proc/1/fd/1", "2>", "/proc/1/fd/2"]
