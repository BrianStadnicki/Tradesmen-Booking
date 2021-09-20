web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
worker: REDIS_URL="redis://redistogo:a3bd10647d38ddb7f40b2f43039e87e5@dory.redistogo.com:10972/" bundle exec sidekiq -c 5