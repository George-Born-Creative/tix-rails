Delayed::Job.enqueue EventsCacheJob.new
puts 'CACHE TEMPLATES INITIALIZER'