# Building docker image

```
docker-compose up
docker-compose run rails bash -l -c "bundle exec rake db:create db:migrate"
```