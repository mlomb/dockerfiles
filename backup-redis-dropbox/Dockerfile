FROM alpine:edge

RUN apk update
RUN apk add redis curl

ENV REDIS_HOST ""
ENV REDIS_PORT 6379
ENV REDIS_PASSWORD ""
ENV DROPBOX_FILE "dump"
ENV DROPBOX_ACCESS_TOKEN ""
ENV CRON_SCHEDULE "0 0 * * *"

COPY run.sh run.sh
COPY backup.sh backup.sh

CMD ["sh", "run.sh", ">", "/proc/1/fd/1", "2>", "/proc/1/fd/2"]
