web: bundle exec thin start -p $PORT
worker: bundle exec rake jobs:work
# redis: redis-server
# resque-worker: JOBS_PER_FORK=20 INTERVAL=10 VVERBOSE=1  QUEUE="*" VERBOSE=true bundle exec rake resque:work 
# pubsub:  bundle exec thin start -p $PORT -R ./faye.ru
