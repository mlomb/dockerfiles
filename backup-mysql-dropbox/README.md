# Example

```yml
version: "3"
services:
  db:
    image: "mariadb"
    restart: always
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_ROOT_PASSWORD: "password"
    volumes:
      - ./backup.sql:/docker-entrypoint-initdb.d/init.sql:ro
  backup:
    image: "mlomb/backup-mysql-dropbox"
    restart: always
    environment:
      MYSQL_HOST: "db"
      MYSQL_USER: "root"
      MYSQL_PASSWORD: "password"
      DATABASES: "mydb"
      CRON_SCHEDULE: "0 0 * * *" # once a day
      DROPBOX_FILEPATH: "cuentas"
      DROPBOX_ACCESS_TOKEN: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    depends_on:
      - db
```

Based on [this repo](https://github.com/suin/dockerfiles/tree/master/mysql-backup-dropbox).
