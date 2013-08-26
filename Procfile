web: bundle exec thin start -p $PORT -e $RACK_ENV 
worker: bundle exec rake jobs:work
log: tail -f log/development.log
# guard:     bundle exec guard

# redis: redis-server
# resque-worker: JOBS_PER_FORK=20 INTERVAL=10 VVERBOSE=1  QUEUE="*" VERBOSE=true bundle exec rake resque:work 
# pubsub:  bundle exec thin start -p $PORT -R ./faye.ru