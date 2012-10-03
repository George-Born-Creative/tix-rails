# require 'resque/tasks'
# 
# task "resque:setup" => :environment do
#   Resque.redis.namespace = "resque:tix"
#   # Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
# end