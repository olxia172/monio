# Building docker image
On your local machine
```bash
docker build . -t monio
docker tag monio macbury/monio:latest
docker push macbury/monio:latest
```

# Installing on server

Create docker compose file on the target server

```yaml
version: '3'
services:
  postgres:
    image: postgres:10
    restart: always
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      PGDATA: /data
    volumes:
      - ./postgresql:/data
  monio:
    image: macbury/monio:latest
    restart: always
    ports:
      - 3000:3000
    environment:
      RAILS_SERVE_STATIC_FILES: 'true'
      RAILS_ENV: production
      SECRET_KEY_BASE: 'ABCDS'
      DATABASE_URL: "postgres://postgres:postgres@postgres:5432/monio_production"

```

and Rrn these commands

```bash
docker-compose up -d
docker-compose run monio bash -l -c "bundle exec rake db:create db:migrate"
```
