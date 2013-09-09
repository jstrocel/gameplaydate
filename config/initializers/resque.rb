ENV["REDISTOGO_URL"] ||= "redis://jtstrocel:ghyx1ty7whi9zy@crestfish.redistogo.com:9385/"
uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)