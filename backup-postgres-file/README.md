# Example

```yml
version: "2"
services:
  db:
    image: postgres:alpine
    restart: always
    environment:
      POSTGRES_USER=postgres
      POSTGRES_PASSWORD=password

  backup:
    image: "mlomb/backup-postgres-dropbox"
    restart: always
    environment:
      POSTGRES_HOST: "db"
      POSTGRES_PORT: 5432
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "password"
      DATABASES: "test"
      DATABASES: "mydb"
      CRON_SCHEDULE: "0 0 * * *" # once a day
      TARGET_FOLDER: "/backups"
    depends_on:
      - db
```
