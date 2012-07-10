uri = URI.parse(ENV["REDISTOGO_URL"])
Redis.current = REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
