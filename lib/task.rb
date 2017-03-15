class Task
  class << self
    def connection
      @redis ||= Redis.new(url: 'redis://localhost:6379')
    end
  end
end
