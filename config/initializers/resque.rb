ENV["REDISTOGO_URL"] ||= "redis://redistogo:23f27f6c8fcaec3f4f2be611f06f9e7a@crestfish.redistogo.com:9385/"
uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)