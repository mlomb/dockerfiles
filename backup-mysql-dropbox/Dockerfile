FROM alpine:edge

RUN apk update
RUN apk add mysql-client curl

ENV MYSQL_HOST ""
ENV MYSQL_PORT 3306
ENV MYSQL_USER "root"
ENV MYSQL_PASSWORD ""
ENV DROPBOX_FILE "backup.sql"
ENV DROPBOX_ACCESS_TOKEN ""
ENV CRON_SCHEDULE "0 0 * * *"

RUN echo "* * * * * /backup.sh" > /etc/crontabs/root
COPY backup.sh backup.sh

CMD ["crond", "-f", "-d", "8", ">", "/proc/1/fd/1", "2>", "/proc/1/fd/2"]
