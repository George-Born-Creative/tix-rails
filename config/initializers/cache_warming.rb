# Notes on 'singleton' delayed_job in initializer 
# (example: long-runing cache warming )
# 
# [SR] Aug 25, 2013
# 
# 1. Jobs will be enqueued by each worker/dyno instance
#  
# 2. When processes exit, jobs will still be on the queue.
#
# Current solution: 'last man wins'
# Each enqueued job destroys existing 
# jobs of same type.
# 
# 3. rake:db:migrate initializes rails and wont have schema
#    so don't try and enqueue delayed job in the test env.

if not ENV['RAILS_ENV'] == 'test'
  Delayed::Job.enqueue PageCacheWarmingJob.new(1) # hardcoded account#1 
end