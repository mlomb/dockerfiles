FROM alpine:edge

RUN apk update
RUN apk add postgresql-client curl

ENV POSTGRES_HOST ""
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER "postgres"
ENV POSTGRES_PASSWORD ""
ENV POSTGRES_DUMP_OPTS ""
ENV TARGET_FOLDER "database_backups"
ENV CRON_SCHEDULE "0 0 * * *"

COPY run.sh run.sh
COPY backup.sh backup.sh

CMD ["sh", "run.sh", ">", "/proc/1/fd/1", "2>", "/proc/1/fd/2"]