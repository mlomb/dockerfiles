# Example

```yml
version: "3"
services:
  db:
    image: "redis:alpine"
    restart: always
    volumes:
      - ./data:/data
  backup:
    image: "mlomb/backup-redis-dropbox"
    restart: always
    environment:
      REDIS_HOST: "db"
      CRON_SCHEDULE: "* * * * *"
      DROPBOX_FILEPATH: "dump"
      DROPBOX_ACCESS_TOKEN: "XXXXXXXXXXXXXX"
    depends_on:
      - db
```
